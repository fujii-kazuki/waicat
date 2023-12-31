class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_deleted_user, if: :user_signed_in?
  before_action :check_guest_user, only: [:edit, :update, :confirm], if: :user_signed_in?
  before_action :check_current_user, only: [:edit, :update, :confirm], if: :user_signed_in?

  def show
    @user = User.find(params[:id])
    if current_user?(@user)
      check_guest_user
      @cats = @user.cats.where(deleted_flag: false).page(params[:page]).per(6)
    else
      @cats = @user.cats.published.page(params[:page]).per(6)
    end
    @current_page = @cats.current_page
    @total_pages = @cats.total_pages == 0 ? 1 : @cats.total_pages
    @total_count = @cats.total_count
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      @user.update(avatar: nil) if params[:user][:avatar].nil? #プロフィール画像が設定されていないなら削除
      flash[:success] = '会員情報の更新が完了しました。'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def confirm
    cats = current_user.cats
    candidates = current_user.candidates
    # 里親募集の掲載に相談中、里親決定のもの
    # または里親立候補後の話し合い途中であれば、退会をキャンセル
    if cats.exists?(publication_status: ['in_consultation', 'foster_parents_decided']) ||
       candidates.exists?(status: ['in_consultation', 'foster_parents_decided'])

      flash[:alert] = 'お客様は里親譲歩の話し合い最中の為、退会できません。'
      redirect_to user_path(current_user.id)
    end
  end

  def leave
    user = current_user
    # 公開中の里親募集の掲載を募集終了にする
    user.cats.where(publication_status: 'public').each do |cat|
      cat.update(publication_status: 'recruitment_closed')
    end
    user.update(deleted_flag: true) # 論理削除
    reset_session #ログアウト
    flash[:success] = '退会が完了しました。ご利用ありがとうございました。'
    redirect_to root_path
  end

  private

  # ストロングパラメーター
  def user_params
    params.require(:user).permit(:avatar, :name, :profile, :telephone_number, :email, :postal_code, :prefecture, :city)
  end
  
  # 退会済みの会員か確認
  def check_deleted_user
    user = User.find(params[:id])
    if user.deleted_flag
      flash[:alert] = '指定の会員は退会されていませす。'
      redirect_back(fallback_location: root_path) 
    end
  end

  # ログインユーザーか確認
  def check_current_user
    user = User.find(params[:id])
    redirect_back(fallback_location: root_path) if !current_user?(user)
  end
end
