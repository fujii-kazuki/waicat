class Public::NoticesController < ApplicationController
  include AjaxHelper 
  
  before_action :authenticate_user!
  before_action :check_guest_user, if: :user_signed_in?
  before_action :check_correct_user, only: [:confirm]
  
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

  private

  def check_correct_user
    if Notice.find(params[:notice_id]).user_id != current_user.id
      flash[:alert] = '申し訳ございませんが、その操作を行うことはできません。'
      respond_to do |format|
        format.js { render ajax_redirect_to(notices_path) }
      end
    end
  end
end
