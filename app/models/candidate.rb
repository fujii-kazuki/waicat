class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :cat
end
