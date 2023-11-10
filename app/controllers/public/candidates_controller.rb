class Public::CandidatesController < ApplicationController
  def confirm
    @cat = Cat.find(params[:cat_id])
    
    # 既に立候補済みか確認
    if current_user.candidated_foster_parent?(@cat.id)
      flash[:danger] = '既に立候補済みです。'
      redirect_to cat_path(@cat.id)
    end
  end

  def create
    @cat = Cat.find(params[:cat_id])
    # 確認チェックボックスにチェックがされているか確認
    if params[:confirmed]
      # 既に立候補済みか確認
      if !current_user.candidated_foster_parent?(@cat.id)
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
      else
        flash[:danger] = '既に立候補済みです。'
        redirect_to cat_path(@cat.id)
      end
    else
      flash[:danger] = '「里親募集の掲載、条件等を全て確認しました。」にチェックをしてください。'
      redirect_to confirm_cat_candidates_path(@cat.id)
    end
  end
end
