class Admin::CommentsController < ApplicationController
  def index
    if params[:cat_id]
      @comments = Comment.where(cat_id: params[:cat_id]).order(created_at: :desc)
    elsif params[:user_id]
      @comments = Comment.where(user_id: params[:user_id]).order(created_at: :desc)
    end
  end
end
