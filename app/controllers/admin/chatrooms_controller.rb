class Admin::ChatroomsController < ApplicationController
  def index
    # パラメーターに会員IDが含まれていない場合
    @q = Chatroom.ransack(params[:q])
    @chatrooms = @q.result.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages.reverse
    @candidater = @chatroom.candidate.user #里親立候補者
    @recruiter = @chatroom.chat_partner(@candidater) #里親募集者
    @cat = @chatroom.candidate.cat
  end

  def leave
    chatroom = Chatroom.find(params[:chatroom_id])
    chatroom.update(deleted_flag: true)
    flash[:notice] = 'チャットルームを閉じました。'
    redirect_back(fallback_location: root_path)
  end
end
