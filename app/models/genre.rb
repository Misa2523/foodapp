class Genre < ApplicationRecord

  #アソシエーション
  has_many :home_foods, dependent: :destroy

  #バリデーション設定
  validates :name, uniqueness: true, presence: true #uniqueness：一意性があるか

end
