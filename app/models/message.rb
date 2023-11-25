class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :body, presence: true

  # メッセージを作成後、送信
  def self.create_and_send(user_id:, chatroom_id:, body:)
    # レコードを作成
    message = self.create(
      user_id: user_id,
      chatroom_id: chatroom_id,
      body: body
    )

    # リアルタイムチャットを表示
    ActionCable.server.broadcast 'message_channel', {
      user: message.user,
      message_body: message.body,
      message_created_at: message.created_at.strftime('%Y/%m/%d %H:%M')
    }

    return message
  end

  # 空内容判定
  def empty_body?
    /\A[\s\u3000]+\z/.match(body) || #半角の空白類文字+全角空白
    /\A[[:space:]]+\z/.match(body) || #Unicode的空白文字全般
    body.blank? #空文字列
  end
end
