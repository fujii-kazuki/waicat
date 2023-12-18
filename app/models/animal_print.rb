class AnimalPrint < ApplicationRecord
  # 全ての猫の毛の柄名の文字列を配列で返す
  def self.all_names_array
    self.all.pluck(:name)
  end
end
