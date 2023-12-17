class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, if: :user_signed_in?

  def index
    @cat = Cat.find(params[:cat_id])
    # 掲載ステータスが公開、相談中でなければ詳細ページへリダイレクト
    if @cat.publication_status != 'public' && @cat.publication_status != 'in_consultation'
      flash[:alert] = '現在そちらの掲載へコメントはできません。'
      redirect_to cat_path(@cat.id)
    end
    @comments = @cat.comments
    @comment = Comment.new
  end

  def create
    @cat = Cat.find(params[:cat_id])
    @comment = Comment.new(comment_params)
    @comment.cat_id = @cat.id
    @comment.user_id = current_user.id

    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました。'
      # 掲載のコメントに関与する会員全員に通知を送信
      comment_notice(
        sender: current_user, #送信者
        recipients_id: @cat.comments.where.not(user_id: current_user.id).pluck(:user_id).uniq, #受信者ID（一意なユーザーIDの配列）
        comment: @comment #コメント
      )
    else
      flash.now[:alert] = '内容を入力してください。'
    end

    @comments = @cat.comments
  end

  def destroy
    Comment.find(params[:id]).update(deleted_flag: true)
    @cat = Cat.find(params[:cat_id])
    @comments = @cat.comments
    flash.now[:success] = 'コメントを削除しました。'
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
