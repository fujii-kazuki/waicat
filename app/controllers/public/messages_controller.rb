class Public::MessagesController < ApplicationController
  include AjaxHelper

  before_action :authenticate_user!
  before_action :check_guest_user, if: :user_signed_in?
  before_action :check_correct_user, only: [:create]

  def create
    chatroom = Chatroom.find(params[:chatroom_id])

    # 削除フラグ確認
    if chatroom.deleted_flag
      flash.now[:alert] = 'このチャットルームは既に終了しています。'
    else
      message = Message.new(message_params)
      # 空メッセージ確認
      if message.empty_body?
        flash.now[:alert] = '内容を入力してください。'
      else
        # メッセージを送信
        @message = Message.create_and_send(
          user_id: current_user.id,
          chatroom_id: chatroom.id,
          body: params[:message][:body]
        )

        # チャット相手に通知を送信
        message_notice(
          sender: @message.user, #送信者
          recipient: chatroom.chat_partner(current_user), #受信者
          message: @message #メッセージ
        )
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  # チャット相手に通知を送信
  def message_notice(sender:, recipient:, message:) #送信者, 受信者, メッセージ
    # 通知を作成
    Notice.create(
      user_id: recipient.id,
      title: "#{sender.name}さんとのチャットルームにメッセージの着信がありました",
      body: "#{message.body}",
      url: chatroom_path(message.chatroom.id)
    )
  end

  def check_correct_user
    chatroom = Chatroom.find(params[:chatroom_id])
    chatroom_user = chatroom.chatroom_users.select { |chatroom_user| chatroom_user.user_id == current_user.id }
    if chatroom.deleted_flag || chatroom_user.empty?
      flash[:alert] = '申し訳ございませんが、その操作を行うことはできません。'
      respond_to do |format|
        format.js { render ajax_redirect_to(chatrooms_path) }
      end
    end
  end
end