class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :cat
  has_one :chatroom

  validates :status, presence: true

  # 0:相談中, 1:里親決定, 2:譲渡完了, 3:お断り
  enum status: { in_consultation: 0, foster_parents_decided: 1, transfer_completed: 2, declined: 3 }, _prefix: :status
end
