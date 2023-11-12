class Public::NoticesController < ApplicationController
  def index
    @notices = current_user.notices.order(created_at: :desc)
  end
end
