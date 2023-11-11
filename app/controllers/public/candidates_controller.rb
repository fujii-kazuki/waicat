class Public::CandidatesController < ApplicationController
  def confirm
    @cat = Cat.find(params[:cat_id])
    
    # 立候補可能か確認
    can_candidate?(@cat)
  end

  def create
    @cat = Cat.find(params[:cat_id])
    # 確認チェックボックスにチェックがされているか確認
    if params[:confirmed]
      # 立候補可能か確認
      if can_candidate?(@cat)
        # 掲載ステータスを「相談中」に変更
        @cat.update(publication_status: 'in_consultation')
        # 立候補レコードを作成
        candidate = current_user.candidates.create(cat_id: @cat.id)
        # チャットルームレコードを作成
        chatroom = Chatroom.create(candidate_id: candidate.id)
        # チャットルームユーザーレコードを2つ作成
        # 1つのチャットルームにユーザー2名（里親募集者と立候補者）を登録
        chatroom.chatroom_users.create(user_id: @cat.user.id)
        chatroom.chatroom_users.create(user_id: current_user.id)
        # チャットルームページへリダイレクト
        redirect_to chatroom_path(chatroom.id)
      end
    else
      flash[:danger] = '「里親募集の掲載、条件等を全て確認しました。」にチェックをしてください。'
      redirect_to confirm_cat_candidates_path(@cat.id)
    end
  end

  def decide
    cat = Cat.find(params[:cat_id])
    candidate = Candidate.find(params[:candidate_id])

    # 既に掲載ステータスが「里親決定」になっていないかチェック
    if !cat.publication_status == 'foster_parents_decided' || !candidate.status = 'foster_parents_decided'
      # 掲載ステータスを「里親決定」に変更
      cat.update(publication_status: 'foster_parents_decided')
      # 立候補ステータスを「里親決定」に変更
      candidate.update(status: 'foster_parents_decided')
      # 里親立候補者に対してメッセージを送信
      message = current_user.messages.create(
        chatroom_id: candidate.chatroom.id,
        body: "※こちらは自動送信メッセージです

              #{candidate.user.name}さんを#{cat.name}#{}の里親に決定しました！
              これから#{cat.name}の譲渡に向けて、

              ・譲渡場所
              ・譲渡場所への集合時間
              ・その他連絡事項や必要な物など

              上記の話し合いを行いましょう！

              また、後日無事に#{cat.name}の譲渡が終わりましたら、#{candidate.user.name}さんは「受け取り完了ボタン」を押してください。"
      )

      flash[:notice] = "#{cat.name}の里親を決定しました。"
    end
    
    # チャットルームへリダイレクト
    redirect_to chatroom_path(candidate.chatroom.id)
  end

  def decline

  end

  private

  # 立候補可能か確認
  def can_candidate?(cat)
    # 掲載ステータスが「公開」かどうか
    if !cat.published?
      flash[:danger] = '先ほどの掲載は現在、里親募集を行なっておりません。'
      redirect_to cats_path
      return false

    # 既に立候補済みか確認
    elsif current_user.candidated_foster_parent?(cat.id)
      flash[:danger] = '既に立候補済みです。'
      redirect_to cat_path(cat.id)
      return false

    # 掲載者本人か確認
    elsif current_user.is_cat_poster?(cat.id)
      flash[:danger] = '掲載者本人は里親に立候補できません。'
      redirect_to cat_path(cat.id)
      return false

    else
      return true
    end
  end
end
