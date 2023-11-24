class Public::NoticesController < ApplicationController
  def index
    @notices = current_user.notices.order(created_at: :desc).page(params[:page]).per(20)
  end

  def confirm
    @notice = Notice.find(params[:notice_id])
    @notice.update(readed_flag: true)
    render :content
  end

  def search
    case params[:sort]
    when '新しい順' then
      @notices = current_user.notices
    when '古い順' then
      @notices = current_user.notices.reverse
    end

    case params[:pattern]
    when '全て' then
      # 何もしない
    when '未読のみ' then
      @notices = @notices.select { |notice| !notice.readed_flag }
    when '既読のみ' then
      @notices = @notices.select { |notice| notice.readed_flag }
    end

    # ページネーションに対応
    @notices = Kaminari.paginate_array(@notices).page(params[:page]).per(10)
    
    render :index
  end
end
