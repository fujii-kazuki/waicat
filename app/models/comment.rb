class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :cat

  validates :body, presence: true
end
