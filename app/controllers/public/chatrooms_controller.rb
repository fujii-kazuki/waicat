class Public::ChatroomsController < ApplicationController
  def index
    @user = current_user
    @chatrooms = @user.chatroom_users.map { |chatroom_user| chatroom_user.chatroom }
    @active_chatrooms = @chatrooms.select { |chatroom| chatroom.deleted_flag == false }
    @passive_chatrooms = @chatrooms.select { |chatroom| chatroom.deleted_flag == true }
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages
    @candidate = @chatroom.candidate
    @cat = @candidate.cat
  end
end
