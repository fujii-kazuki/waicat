class Public::ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, if: :user_signed_in?

  def index
    @user = current_user
    @chatrooms = @user.chatroom_users.map { |chatroom_user| chatroom_user.chatroom }
    @chatrooms.sort! { |cr_a, cr_b| cr_b.messages.first.created_at <=> cr_a.messages.first.created_at }
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages
    @message = Message.new
    @candidate = @chatroom.candidate
    @cat = @candidate.cat
  end
end
