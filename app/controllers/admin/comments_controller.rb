class Admin::CommentsController < ApplicationController
  def index
    if params.dig(:q, :cat_id)
      @cat = Cat.find(params[:cat_id])
      @q = Comment.where(cat_id: @cat.id).ransack(params[:q])
      @comments = @q.result.order(created_at: :desc).page(params[:page]).per(15)
      @search_form_path = admin_cat_comments_path

    elsif params.dig(:q, :user_id)
      @user = User.find(params[:user_id])
      @q = Comment.where(user_id: @user.id).ransack(params[:q])
      @comments = @q.result.order(created_at: :desc).page(params[:page]).per(15)
      @search_form_path = admin_user_comments_path
    end
  end

  def leave
    comment = Comment.find(params[:comment_id])
    comment.update(deleted_flag: true)
    flash[:notice] = "コメント「#{comment.body.truncate(30)}」を削除しました。"

    if params.dig(:q, :cat_id)
      redirect_to admin_cat_comments_path(cat_id: params[:q][:cat_id], q: { cat_id: params[:q][:cat_id] })
    elsif params.dig(:q, :user_id)
      redirect_to admin_user_comments_path(user_id: params[:q][:user_id], q: { user_id: params[:q][:user_id] })
    end
  end
end