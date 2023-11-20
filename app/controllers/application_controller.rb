class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :authenticate_admin!, if: :admin_url?
  before_action :check_publication_period

  private

  # 掲載期間を確認
  def check_publication_period
    cats = Cat.where(publication_status: 'public').where('publication_deadline < ?', Time.zone.now)
    cats.update_all(publication_status: 'publication_deadline')
  end
end
