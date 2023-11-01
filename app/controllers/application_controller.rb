class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url? 

  # URLにadminが含まれているか判定
  def admin_url?
    request.fullpath.include?("/admin")
  end
end
