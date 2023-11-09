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
  validates :postal_code, presence: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :telephone_number, presence: true, numericality: { only_integer: true }, length: { in: 10..11 }

  devise :validatable
  
  def self.guest
    user = find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'ゲストユーザー'
      user.postal_code = '0000000'
      user.prefecture = '***'
      user.city = '***'
      user.telephone_number = '00000000000'
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
