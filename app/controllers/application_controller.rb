class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url?
  before_action :check_publication_period

  helper_method :admin_url?

  private

  # URLにadminが含まれているか判定
  def admin_url?
    request.fullpath.include?("/admin")
  end

  # 掲載期間を確認
  def check_publication_period
    cats = Cat.where(publication_status: 'public').where('publication_deadline < ?', Time.zone.now)
    cats.update_all(publication_status: 'publication_deadline')
  end
end
