class Admin::ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all.order(created_at: :desc)
  end

  def show
  end
end
