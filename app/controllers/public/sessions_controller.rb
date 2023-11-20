# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_user, only: [:create]

  # ゲストログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:notice] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_path
  end
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # def after_sign_in_path_for(resource)
  #   users_my_page_path
  # end

  # ログアウト後にトップページへリダイレクト
  def after_sign_out_path_for(resource)
    root_path
  end

  # 会員ログイン時の削除フラグ判定
  def reject_inactive_user
    user = User.find_by(email: params[:user][:email])
    if user
      if user.valid_password?(params[:user][:password]) && user.deleted_flag
        flash[:alert] = 'お客様は退会済みです。申し訳ございませんが、再度新規登録をお願いします。'
        redirect_to new_user_registration_path
      end
    end
  end
  
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
