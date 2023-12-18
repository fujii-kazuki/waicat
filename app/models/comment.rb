class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :cat

  validates :body, presence: true

  private

  # Gem「ransack」の検索対象カラムをホワイトリストに登録
  def self.ransackable_associations(auth_object = nil)
    ['id', 'created_at', 'deleted_flag']
  end
  def self.ransackable_attributes(auth_object = nil)
    ['id', 'created_at', 'deleted_flag']
  end
end