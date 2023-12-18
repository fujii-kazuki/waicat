class Breed < ApplicationRecord
  # 全ての猫の種類名の文字列を配列で返す
  def self.all_names_array
    self.all.pluck(:name)
  end
end
