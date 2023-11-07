class Cat < ApplicationRecord
  belongs_to :user

  has_many :bookmarks
  has_many :candidates
  has_many :comments

  has_many_attached :photos

  validates :photos, content_type: [:jpg, :jpeg, :png], size: { less_than: 5.megabytes }
  validate :photos_check # ここでバリデーションエラー対象の写真を削除
  validates :photos, limit: { min: 3, max: 10, message: 'は最低でも3枚アップロードしてください' }
    
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
    validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
    validates :prefecture, presence: true
    validates :municipalitie, presence: true
    validates :publication_date, presence: true
    validates :publication_deadline, presence: true
    validate :confirm_publication_deadline
  end

  validates :publication_status, presence: true

  # オス, メス
  enum gender: { male: 0, female: 1 }, _prefix: :gender
  # 短毛, 長毛
  enum hair_length: { short: 0, long: 1 }, _prefix: :hair_length
  # 下書き, 公開, 非公開, 相談中, 募集終了, 里親決定, 掲載締め切り
  enum publication_status: { draft: 0, public: 1, private: 2, in_consultation: 3, recruitment_closed: 4, foster_parents_decided: 5, publication_deadline: 6 }, _prefix: :publication_status

  private

  # 掲載ステータスが公開になっているかの判定
  def published?
    publication_status == 'public'
  end

  # 掲載期間が今日の日付以降か確認
  def confirm_publication_deadline
    return if publication_deadline.blank?
    errors.add(:publication_deadline, "は本日から最低でも翌日以降の日付を選択してください") if publication_deadline < Time.zone.now.tomorrow
    errors.add(:publication_deadline, "は掲載日（新規の掲載の場合は本日）から当日含む14日以内の日付を選択してください") if publication_deadline > publication_date.since(2.weeks)
  end

  # バリデーションエラー対象の写真を削除
  def photos_check
    if self.photos.any?
      self.photos.select! do |photo|
        photo.blob.content_type.in?(%('image/jpg image/jpeg image/png')) && photo.blob.byte_size < 5.megabytes
      end
    end
  end
end
