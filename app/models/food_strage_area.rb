class FoodStrageArea < ApplicationRecord

  #バリデーション設定
  validates :name, presence: true
  validates :place, presence: true

  enum place: {冷凍庫:0, 冷蔵庫:1, 常温:2}

end
