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
    # 相手のメッセージを既読にする
    read_messages(@messages)

    @message = Message.new
    @candidate = @chatroom.candidate
    @cat = @candidate.cat
  end

  private

  # 相手のメッセージを既読にする
  def read_messages(messages)
    messages.each do |message|
      message.update(readed_flag: true) if message.user_id != current_user.id
    end
  end
end
