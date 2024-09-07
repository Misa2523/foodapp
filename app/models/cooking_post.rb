class CookingPost < ApplicationRecord

  #アソシエーション
  belongs_to :customer

  has_one_attached :cooking_post_image

  #バリデーション設定
  validates :name, presence: true
  validates :introduction, presence: true

end
