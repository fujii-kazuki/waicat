class Public::NoticesController < ApplicationController
  def index
    @notices = current_user.notices.order(created_at: :desc)
  end

  def confirm
    @notice = Notice.find(params[:notice_id])
    @notice.update(readed_flag: true)
    render :content
  end

  def search
    case params[:sort]
    when '新しい順' then
      @notices = current_user.notices.order(created_at: :desc)
    when '古い順' then
      @notices = current_user.notices.order(created_at: :asc)
    end

    case params[:pattern]
    when '全て' then
      # 何もしない
    when '未読のみ' then
      @notices = @notices.select { |notice| !notice.readed_flag }
    when '既読のみ' then
      @notices = @notices.select { |notice| notice.readed_flag }
    end
    
    render :index
  end
end
