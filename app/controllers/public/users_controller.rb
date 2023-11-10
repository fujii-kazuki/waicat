class Public::UsersController < ApplicationController
  def show
  end

  def edit
  end

  def check
  end

  def leave
    current_user.update(deleted_flag: true)
    reset_session
    flash[:notice] = '退会処理が完了しました。ご利用ありがとうございました。'
    redirect_to root_path
  end
end
