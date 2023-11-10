class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :cats
  has_many :candicates
  has_many :comments
  has_many :notices
  has_many :bookmarks
  has_many :messages
  has_many :activities
  has_many :chatroom_users
  has_many :contacts

  validates :name, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }

  devise :validatable
  
  def self.guest
    user = find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'ゲストユーザー'
      user.postal_code = '1234567'
      user.address = '**********'
      user.telephone_number = '09012345678'
      user.password = SecureRandom.urlsafe_base64
    end
    user.update(deleted_flag: false)
    return user
  end

  # ゲストユーザー判定
  def is_guest_user?
    email == 'guest@example.com' ? true : false
  end

  # 猫のブックマーク判定
  def bookmarked_cat?(cat_id)
    bookmarks.exists?(cat_id: cat_id)
  end
end
