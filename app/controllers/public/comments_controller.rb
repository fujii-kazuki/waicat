class Public::CommentsController < ApplicationController
  def index
    @cat = Cat.find(params[:cat_id])
    @comments = @cat.comments
    @comment = Comment.new
  end

  def create
    @cat = Cat.find(params[:cat_id])
    @comments = @cat.comments
    @comment = Comment.new(comment_params)
    @comment.cat_id = @cat.id
    @comment.user_id = current_user.id

    if @comment.save
      flash[:notice] = 'コメントを投稿しました。'
      # 掲載のコメントに関与する会員全員に通知を送信
      comment_notice(
        sender: current_user, #送信者
        recipients_id: @cat.comments.where.not(user_id: current_user.id).pluck(:user_id).uniq, #受信者ID（一意なユーザーIDの配列）
        comment: @comment #コメント
      ) #
    else
      flash[:notice] = ''
    end
  end

  def destroy
    @cat = Cat.find(params[:cat_id])
    @comments = @cat.comments
    @cat.comments.find(params[:id]).destroy
    flash[:notice] = 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  # 掲載のコメントに関与する会員全員に通知を送信
  def comment_notice(sender:, recipients_id:, comment:) #送信者, 受信者ID, コメント
    recipients_id.each do |recipient_id|
      # 通知を作成
      Notice.create(
        user_id: recipient_id,
        title: "あなたがコメントした#{comment.cat.name}の里親募集の掲載にコメントがありました",
        body: "コメントユーザー：#{current_user.name}
              内容：#{comment.body}",
        url: cat_comments_path(comment.cat.id)
      )
    end
  end
end
