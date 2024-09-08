class FoodStrageArea < ApplicationRecord

  #バリデーション設定
  validates :name, uniqueness: true, presence: true #同じ食材を別々で登録しないため一意性を設定
  validates :place, presence: true

  enum place: {冷凍庫:0, 冷蔵庫:1, 常温:2}

end
