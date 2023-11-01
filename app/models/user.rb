class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cats
  has_many :candicates
  has_many :comments
  has_many :notices
  has_many :bookmarks
  has_many :messages
  has_many :activities
  has_many :chatroom_users
  has_many :contacts
end
