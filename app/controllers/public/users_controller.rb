class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, only: [:edit, :confirm], if: :user_signed_in?
  before_action :check_current_user, only: [:edit, :confirm], if: :user_signed_in?
  before_action :check_deleted_user, if: :user_signed_in?

  def show
    @user = User.find(params[:id])
    if current_user?(@user)
      check_guest_user
      @cats = @user.cats.where(deleted_flag: false).page(params[:page]).per(6)
    else
      @cats = @user.cats.where(
        publication_status: ['public', 'in_consultation', 'foster_parents_decided', 'recruitment_closed'],
        deleted_flag: false
      ).page(params[:page]).per(6)
    end
    @current_page = @cats.current_page
    @total_pages = @cats.total_pages == 0 ? 1 : @cats.total_pages
    @total_count = @cats.total_count
  end

  def edit
    @user = User.find(params[:id])
  end

  def confirm
  end

  private
  
  # 退会済みの会員か確認
  def check_deleted_user
    user = User.find(params[:id])
    redirect_back(fallback_location: root_path) if user.deleted_flag
  end

  # ログインユーザーか確認
  def check_current_user
    user = User.find(params[:id])
    if !current_user?(user)
      redirect_back(fallback_location: root_path)
    end
  end
end
