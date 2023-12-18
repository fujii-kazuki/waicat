class Admin::UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
  end

  def leave
    user = User.find(params[:user_id])
    user.update(deleted_flag: true)
    flash[:notice] = 'この会員を削除しました。'
    # 削除した会員の掲載を全て削除
    user.cats.update_all(deleted_flag: true)
    redirect_to admin_user_path(user.id)
  end
end
