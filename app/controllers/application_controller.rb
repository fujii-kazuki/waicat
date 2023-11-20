class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :authenticate_admin!, if: :admin_url?
  before_action :check_publication_period
  
  # ゲストユーザー判定
  def guest_signed_in?
    if current_user.is_guest_user?
      # ゲストユーザーなら前のページへリダイレクト
      flash[:alert] = 'そちらの機能をご利用するには新規登録が必要です。'
      redirect_back(fallback_location: root_path) 
    end
  end

  private

  # 掲載期間を確認
  def check_publication_period
    cats = Cat.where(publication_status: 'public').where('publication_deadline < ?', Time.zone.now)
    cats.update_all(publication_status: 'publication_deadline')
  end

end
