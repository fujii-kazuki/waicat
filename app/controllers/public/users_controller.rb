class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_signed_in?, except: [:show], if: :user_signed_in?

  def show
    @user = User.find(params[:id])
    # 詳細ページがゲスト、または退会済みの会員場合、前のページにリダイレクト
    if @user.id == 1 || @user.deleted_flag
      redirect_back(fallback_location: root_path)
    else
      if current_user?(@user)
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
  end

  def confirm
  end
end
