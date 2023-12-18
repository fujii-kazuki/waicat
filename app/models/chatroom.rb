class Chatroom < ApplicationRecord
  has_many :messages, -> { order(created_at: :desc) }
  has_many :chatroom_users
  belongs_to :candidate

  # チャット相手のユーザーを取得
  def chat_partner(current_user)
    ChatroomUser.where(chatroom_id: self.id).where.not(user_id: current_user.id)[0].user
  end

  # 最後に送信されたメッセージを取得
  def last_message
    if messages.any?
      messages.order(created_at: :desc).first
    else
      'メッセージがありません。'
    end
  end

  private

   # Gem「ransack」の検索対象カラムをホワイトリストに登録
   def self.ransackable_attributes(auth_object = nil)
    ['id', 'created_at', 'deleted_flag']
  end
end
