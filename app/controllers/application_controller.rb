class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :authenticate_admin!, if: :admin_url?
  before_action :check_unread_notices, if: proc { user_signed_in? && !current_user.is_guest_user? }
  before_action :check_publication_period, if: proc { user_signed_in? && !current_user.is_guest_user? }
  
  # ゲストユーザーか確認
  def check_guest_user
    if current_user.is_guest_user?
      # ゲストユーザーなら前のページへリダイレクト
      flash[:alert] = 'そちらの機能をご利用するには新規登録が必要です。'
      redirect_back(fallback_location: root_path) 
    end
  end

  private

  # 未読通知数を確認
  def check_unread_notices
    @unread_notices_num = current_user.notices.where(readed_flag: false).count
  end

  # 掲載期間を確認
  def check_publication_period
    cats = Cat.where(publication_status: 'public').where('publication_deadline < ?', Time.zone.now)
    cats.update_all(publication_status: 'publication_deadline')
  end
end
