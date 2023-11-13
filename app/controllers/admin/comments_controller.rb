class Admin::CommentsController < ApplicationController
  def index
    if params[:cat_id]
      @comments = Comment.where(cat_id: params[:cat_id]).order(created_at: :desc)
    elsif params[:user_id]
      @comments = Comment.where(user_id: params[:user_id]).order(created_at: :desc)
    end
  end

  def leave
    comment = Comment.find(params[:comment_id])
    comment.update(deleted_flag: true)
    flash[:notice] = "コメント「#{comment.body.truncate(30)}」を削除しました。"
    redirect_back fallback_location: root_path
  end
end
