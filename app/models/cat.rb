class Cat < ApplicationRecord
  belongs_to :user

  has_many :bookmarks
  has_many :candidates
  has_many :comments
end
