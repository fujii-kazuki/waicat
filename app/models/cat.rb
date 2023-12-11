class Cat < ApplicationRecord
  belongs_to :user

  has_many :bookmarks, -> { order(created_at: :desc) }
  has_many :candidates
  has_many :comments, -> { where(deleted_flag: false).order(created_at: :desc) }

  has_many_attached :photos
  has_one_attached :video

  validates :photos, content_type: [:jpg, :jpeg, :png], size: { less_than: 5.megabytes }
  validate :photos_check # ここでバリデーションエラー対象の写真を削除
  validates :photos, limit: { max: 10, message: 'は10枚以上アップロードできません' }
  validates :photos, limit: { min: 3, message: 'は最低でも3枚アップロードしてください' }, if: :published?
  
  validates :video, content_type: [:mp4, :mov], size: { less_than: 30.megabytes }
  validate :video_check # ここでバリデーションエラー対象の映像を削除
    
  # 掲載ステータスが'public'の時のみ、以下バリデーションが有効
  with_options if: :published? do 
    validates :publication_title, presence: true
    validates :name, presence: true
    validates :age, presence: true
    validates :gender, presence: true
    validates :weight, presence: true
    validates :breed, presence: { message: 'を選択してください' }
    validates :animal_print, presence: { message: 'を選択してください' }
    validates :hair_length, presence: true
    validates :postal_code, presence: true, numericality: { only_integer: true }, length: { is: 7 }
    validates :prefecture, presence: { message: 'を選択してください' }
    validates :city, presence: true
    validates :background, presence: true
    validates :personality, presence: true
    validates :health, presence: true
    validates :delivery_place, presence: true
    validates :publication_date, presence: true
    validates :publication_deadline, presence: true
    validate :confirm_publication_deadline
  end

  validates :publication_status, presence: true

  # 0:オス, 1:メス
  enum gender: { male: 0, female: 1 }, _prefix: :gender
  # 0:短毛, 1:長毛
  enum hair_length: { short: 0, long: 1 }, _prefix: :hair_length
  # 0:下書き, 1:公開, 2:非公開, 3:相談中, 4:里親決定, 5:募集終了, 6:掲載締め切り
  enum publication_status: { draft: 0, public: 1, private: 2, in_consultation: 3, foster_parents_decided: 4, recruitment_closed: 5, publication_deadline: 6 }, _prefix: :publication_status

  # 掲載ステータスが公開になっているかの判定
  def published?
    publication_status == 'public'
  end

  # 掲載の残り期間の文字列を返す
  def get_remaining_period_string
    remaining_period = (publication_deadline - Date.current - 1).to_i
    if remaining_period == 0
      return '本日中'
    else
      return '残り' + remaining_period.to_s + '日'
    end
  end

  # 写真のURLを返す
  def photo_image_url(index, img_type = 'thumbnail') # img_type = original or thumbnail
    if photos.attached?
      if Rails.env.production?
        case img_type
        when 'original' then
          "https://waicat-img-files-original.s3.ap-northeast-1.amazonaws.com/#{photos[index].key}"
        when 'thumbnail' then
          "https://waicat-img-files-resize.s3.ap-northeast-1.amazonaws.com/#{photos[index].key}-thumb.#{photos[index].content_type.split('/').pop}"
        end
      elsif Rails.env.development?
        Rails.application.routes.url_helpers.rails_blob_url(photos[index], only_path: true)
      end
    else
      # デフォルト画像のパスを返す
      ActionController::Base.helpers.asset_path('no-image.png')
    end
  end

  private
  
  # Gem「ransack」の検索対象カラムをホワイトリストに登録
  def self.ransackable_associations(auth_object = nil)
    ['id', 'publication_title', 'age', 'gender', 'breed', 'animal_print', 'prefecture', 'city', 'publication_status', 'publication_date', 'deleted_flag']
  end
  def self.ransackable_attributes(auth_object = nil)
    ['id', 'publication_title', 'age', 'gender', 'breed', 'animal_print', 'prefecture', 'city', 'publication_status', 'publication_date', 'deleted_flag']
  end

  # 掲載期間が今日の日付以降か確認
  def confirm_publication_deadline
    return if publication_deadline.blank?
    errors.add(:publication_deadline, "は本日から最低でも翌日以降の日付を選択してください") if publication_deadline < Time.zone.now.tomorrow
    errors.add(:publication_deadline, "は掲載日（新規の掲載の場合は本日）から当日含む14日以内の日付を選択してください") if publication_deadline > publication_date.since(2.weeks)
  end

  # バリデーションエラー対象の写真を削除
  def photos_check
    if self.photos.any? && self.photos.respond_to?(:select!)
      self.photos.select! do |photo|
        photo.blob.content_type.in?(%('image/jpg image/jpeg image/png')) && photo.blob.byte_size < 5.megabytes
      end
    end
  end

  # バリデーションエラー対象の映像を削除
  def video_check
    if !self.video.blank?
      if !self.video.blob.content_type.in?(%('video/mp4 video/quicktime')) || self.video.blob.byte_size >= 30.megabytes
        self.video = nil
      end
    end
  end
end
