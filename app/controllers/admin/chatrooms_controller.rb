class Admin::ChatroomsController < ApplicationController
  def index
    if params[:user_id]
      chatroom_users = ChatroomUser.where(user_id: params[:user_id])
      @chatrooms = chatroom_users.map { |chatroom_user| chatroom_user.chatroom }
      @chatrooms.reverse
    else
      @chatrooms = Chatroom.all.order(created_at: :desc)
    end
  end

  def show
  end
end
