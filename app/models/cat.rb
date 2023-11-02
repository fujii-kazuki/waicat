class Cat < ApplicationRecord
  belongs_to :user

  has_many :bookmarks
  has_many :candidates
  has_many :comments

  validates :publication_title, presence: true
  validates :name, presence: true
  validates :age, presence: true
  validates :gender, presence: true
  validates :weight, presence: true
  validates :breed, presence: true
  validates :animal_print, presence: true
  validates :hair_length, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :prefecture, presence: true
  validates :municipalitie, presence: true
  validates :publication_date, presence: true
  validates :publication_deadline, presence: true
  validates :publication_status, presence: true

  # オス, メス
  enum gender: { male: 0, female: 1 }, _prefix: :gender
  # 短毛, 長毛
  enum hair_length: { short: 0, long: 1 }, _prefix: :hair_length
  # 下書き, 公開, 非公開, 相談中, 募集終了, 里親決定
  enum publication_status: { draft: 0, public: 1, private: 2, in_consultation: 3, recruitment_closed: 4, foster_parents_decided: 5 }, _prefix: :publication_status
end
