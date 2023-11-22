class Public::CandidatesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, if: :user_signed_in?

  def confirm
    @cat = Cat.find(params[:cat_id])
    
    # 応募可能か確認
    can_candidate?(@cat)
  end

  def create
    @cat = Cat.find(params[:cat_id])
    # 確認チェックボックスにチェックがされているか確認
    if params[:confirmed]
      # 応募可能か確認
      if can_candidate?(@cat)
        # 掲載ステータスを「相談中」に変更
        @cat.update(publication_status: 'in_consultation')
        # 応募レコードを作成
        candidate = current_user.candidates.create(cat_id: @cat.id)
        # チャットルームレコードを作成
        chatroom = Chatroom.create(candidate_id: candidate.id)
        # チャットルームユーザーレコードを2つ作成
        # 1つのチャットルームにユーザー2名（里親募集者と応募者）を登録
        chatroom.chatroom_users.create(user_id: @cat.user.id)
        chatroom.chatroom_users.create(user_id: current_user.id)
        flash[:notice] = '里親の応募とチャットルームの作成が完了しました。'
        # 里親応募メッセージを自動送信
        candidate_message(chatroom)
        # 掲載者に応募通知を送信
        candidate_notice(candidate)
        # チャットルームページへリダイレクト
        redirect_to chatroom_path(chatroom.id)
      end
    else
      flash[:alert] = '「里親募集の掲載、条件等を全て確認しました。」にチェックをしてください。'
      redirect_to confirm_cat_candidates_path(@cat.id)
    end
  end

  def decide
    cat = Cat.find(params[:cat_id])
    candidate = Candidate.find(params[:candidate_id])

    # 既に応募ステータスが「相談中」になっているか確認
    if candidate.status == 'in_consultation'
      # 掲載ステータスを「里親決定」に変更
      cat.update(publication_status: 'foster_parents_decided')
      # 応募ステータスを「里親決定」に変更
      candidate.update(status: 'foster_parents_decided')
      # 里親決定メッセージを自動送信
      decide_foster_parent_message(candidate.chatroom)
      flash[:notice] = "#{cat.name}の里親を決定しました。"
      # 応募者に里親決定通知を送信
      decide_notice(candidate)
    else
      flash[:alert] = '既に里親決定済みか、譲渡済み、またはお断り済みです。'
    end
    # チャットルームページへリダイレクト
    redirect_to chatroom_path(candidate.chatroom.id)
  end

  def decline
    cat = Cat.find(params[:cat_id])
    candidate = Candidate.find(params[:candidate_id])
    chatroom = candidate.chatroom

    # 応募ステータスが相談中か確認
    if candidate.status == 'in_consultation'
      # 掲載ステータスを「公開」に変更
      cat.update(publication_status: 'public')
      # 応募ステータスを「お断り」に変更
      candidate.update(status: 'declined')
      # チャットルームを論理削除
      chatroom.update(deleted_flag: true)
      flash[:notice] = '里親応募をお断りしました。'
      # 応募者に里親お断り通知を送信
      decline_notice(candidate)
      # チャットルーム一覧ページへリダイレクト
      redirect_to chatrooms_path
    else
      flash[:alert] = '既に里親決定済みか、譲渡済み、またはお断り済みです。'
      # チャットルームへリダイレクト
      redirect_to chatroom_path(candidate.chatroom.id)
    end
  end

  private

  # 応募可能か確認
  def can_candidate?(cat)
    # 掲載ステータスが「相談中」かどうか
    if !cat.publication_status == 'in_consultation'
      flash[:alert] = '先ほどの掲載は現在、里親募集を行なっておりません。'
      redirect_to cats_path
      return false

    # 既に応募済みか確認
    elsif current_user.candidated_foster_parent?(cat.id)
      flash[:alert] = '既に応募済みです。'
      redirect_to cat_path(cat.id)
      return false

    # 掲載者本人か確認
    elsif current_user.is_cat_publisher?(cat)
      flash[:alert] = '掲載者本人は里親に応募できません。'
      redirect_to cat_path(cat.id)
      return false

    else
      return true
    end
  end

  # 里親応募メッセージ
  def candidate_message(chatroom)
    # 掲載者の名前
    publisher_name = chatroom.candidate.cat.user.name
    # 猫の名前
    cat_name = chatroom.candidate.cat.name

    current_user.messages.create(
      chatroom_id: chatroom.id,
      body: "※こちらは自動送信メッセージです
      
            #{cat_name}の里親に応募しました！
            こちらのチャットルームにて、
            
            ・簡単な自己紹介
            ・応募に至った経緯など
            ・猫を迎えるに至っての準備など
            
            里親決定に向けて話し合いましょう！"
    )
  end

  # 里親決定メッセージ
  def decide_foster_parent_message(chatroom)
    # 譲渡相手の名前
    candidate_user_name = chatroom.candidate.user.name
    # 猫の名前
    cat_name = chatroom.candidate.cat.name

    current_user.messages.create(
      chatroom_id: chatroom.id,
      body: "※こちらは自動送信メッセージです

            #{candidate_user_name}さんを#{cat_name}の里親に決定しました！
            これから#{cat_name}の譲渡に向けて、

            ・譲渡場所
            ・譲渡場所への集合時間
            ・その他連絡事項や必要な物など

            上記の件にて話し合いましょう！

            また、後日無事に#{cat_name}の譲渡が終わりましたら、#{candidate_user_name}さんは「受け取り完了ボタン」を押してください。"
    )
  end
  
  # 掲載者に通知を送信
  def candidate_notice(candidate)
    publishe_user = candidate.cat.user #里親募集掲載者
    candidate_user = candidate.user #里親応募者
    chatroom = candidate.chatroom #チャットルーム
    cat = candidate.cat #里親募集の猫
    # 通知を作成
    Notice.create(
      user_id: publishe_user.id,
      title: "#{candidate_user.name}さんが#{cat.name}の里親に応募しました",
      body: "#{candidate_user.name}さんが#{cat.name}の里親に応募されたので、リンク先にて#{candidate_user.name}さんとのチャットルームが作成されました。
            これから里親決定に向けて、チャットルームで#{candidate_user.name}さんと話し合いをしましょう。",
      url: chatroom_path(chatroom.id)
    )
  end

  # 応募者に里親決定通知を送信
  def decide_notice(candidate)
    publishe_user = candidate.cat.user #里親募集掲載者
    candidate_user = candidate.user #里親応募者
    chatroom = candidate.chatroom #チャットルーム
    cat = candidate.cat #里親募集の猫
    # 通知を作成
    Notice.create(
      user_id: candidate_user.id,
      title: "おめでとうございます！あなたを#{cat.name}の里親に決定しました。",
      body: "#{cat.name}の飼い主の#{publishe_user.name}さんが、あなたを#{cat.name}の里親に決定しました。
            今後#{cat.name}の譲渡を無事に行えるよう、リンク先のチャットルームにて#{publishe_user.name}さんと話し合いをしましょう。",
      url: chatroom_path(chatroom.id)
    )
  end

  # 応募者に里親お断り通知を送信
  def decline_notice(candidate)
    publishe_user = candidate.cat.user #里親募集掲載者
    candidate_user = candidate.user #里親応募者
    chatroom = candidate.chatroom #チャットルーム
    cat = candidate.cat #里親募集の猫
    # 通知を作成
    Notice.create(
      user_id: candidate_user.id,
      title: "お気の毒ですが、#{cat.name}の里親応募がキャンセルされました。",
      body: "#{cat.name}の飼い主の#{publishe_user.name}さんが、あなたの#{cat.name}の里親応募をキャンセルしました。
            また機会がある事をお祈りしております。",
      url: chatroom_path(chatroom.id)
    )
  end
end