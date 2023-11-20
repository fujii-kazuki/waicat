class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :cats, -> { where(deleted_flag: false).order(created_at: :desc) }
  has_many :candidates
  has_many :comments, -> { where(deleted_flag: false).order(created_at: :desc) }
  has_many :notices, -> { where(deleted_flag: false).order(created_at: :desc) }
  has_many :bookmarks, -> { order(created_at: :desc) }
  has_many :messages, -> { order(created_at: :desc) }
  has_many :activities, -> { order(created_at: :desc) }
  has_many :chatroom_users, -> { order(created_at: :desc) }
  has_many :contacts, -> { order(created_at: :desc) }

  validates :name, presence: true
  validates :postal_code, presence: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :prefecture, presence: { message: 'を選択してください' }
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

  # 里親応募済みかを判定（過去に1度お断りされている方は応募済みと扱わない）
  def candidated_foster_parent?(cat_id)
    candidates.exists?(cat_id: cat_id, status: [0, 1, 2])
  end

  # 掲載者本人か確認
  def is_cat_publisher?(cat)
    id == cat.user.id
  end
end
