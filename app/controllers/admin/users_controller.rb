class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def leave
    user = User.find(params[:user_id])
    user.update(deleted_flag: true)
    flash[:notice] = 'この会員を削除しました。'
    redirect_to admin_user_path(user.id)
  end
end
