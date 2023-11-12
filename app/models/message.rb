class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :body, presence: true

  def empty_body?
    /\A[\s\u3000]+\z/.match(body) || #半角の空白類文字+全角空白
    /\A[[:space:]]+\z/.match(body) || #Unicode的空白文字全般
    body.blank? #空文字列
  end
end
