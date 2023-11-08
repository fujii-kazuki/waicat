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
      redirect_to cat_comments_path(@cat.id)
    else
      render :index
    end
  end

  def destroy
    @cat = Cat.find(params[:cat_id])
    @comments = @cat.comments
    @cat.comments.find(params[:id]).destroy
    flash[:notice] = 'コメントを削除しました。'
    redirect_to cat_comments_path(@cat.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
