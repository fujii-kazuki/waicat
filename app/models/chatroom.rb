class Chatroom < ApplicationRecord
  has_many :messages
  has_many :chatroom_users
  belongs_to :candidate

  # 最後に送信されたメッセージを取得
  def last_message
    if messages.any?
      messages.order(created_at: :desc).first
    else
      'メッセージがありません。'
    end
  end
end
