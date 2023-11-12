class Public::NoticesController < ApplicationController
  def index
    @notices = current_user.notices.order(created_at: :desc)
  end

  def confirm
    @notice = Notice.find(params[:notice_id])
    @notice.update(readed_flag: true)
    render :content
  end
end
