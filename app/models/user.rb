class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_one_attached :avatar
  
  has_many :cats, -> { where(deleted_flag: false).order(created_at: :desc) }
  has_many :candidates
  has_many :comments, -> { where(deleted_flag: false).order(created_at: :desc) }
  has_many :notices, -> { where(deleted_flag: false).order(created_at: :desc) }
  has_many :bookmarks, -> { order(created_at: :desc) }
  has_many :messages, -> { order(created_at: :desc) }
  has_many :activities, -> { order(created_at: :desc) }
  has_many :chatroom_users, -> { order(created_at: :desc) }
  has_many :contacts, -> { order(created_at: :desc) }
  
  validates :avatar, content_type: [:jpg, :jpeg, :png], size: { less_than: 5.megabytes }
  validates :name, presence: true
  validates :postal_code, presence: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :prefecture, presence: { message: 'を選択してください' }
  validates :city, presence: true
  validates :telephone_number, presence: true, numericality: { only_integer: true }, length: { in: 10..11 }

  devise :validatable
  
  # ゲストユーザーのモデルインスタンスを返す（無ければ自動作成）
  def self.guest
    user = find_or_create_by!(email: User.get_guest_user_email) do |user|
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

  # ゲストユーザーのメールアドレスを返す
  def self.get_guest_user_email
    ENV.has_key?('WAICAT_GUEST_EMAIL') ? ENV['WAICAT_GUEST_EMAIL'] : 'guest@example.com'
  end

  # ゲストユーザー判定
  def is_guest_user?
    email == User.get_guest_user_email ? true : false
  end

  # 会員プロフィール画像のURLを返す
  def profile_image_url(img_type = 'thumbnail') # original or thumbnail
    if avatar.attached?
      if Rails.env.production?
        case img_type
        when 'original' then
          "https://waicat-img-files-original.s3.ap-northeast-1.amazonaws.com/#{avatar.key}"
        when 'thumbnail' then
          "https://waicat-img-files-resize.s3.ap-northeast-1.amazonaws.com/#{avatar.key}-thumb.#{avatar.content_type.split('/').pop}"
        end
      elsif Rails.env.development?
        Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
      end
    else
      # デフォルト画像のパスを返す
      ActionController::Base.helpers.asset_path('avatar-default.png')
    end
  end

  # 猫がブックマーク済みか判定
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

  private

  # Gem「ransack」の検索対象カラムをホワイトリストに登録
  def self.ransackable_attributes(auth_object = nil)
    ['id', 'created_at', 'deleted_flag']
  end
end