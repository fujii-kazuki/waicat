class Contact < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  private

  # Gem「ransack」の検索対象カラムをホワイトリストに登録
  def self.ransackable_attributes(auth_object = nil)
    ['id', 'readed_flag', 'created_at']
  end
end
