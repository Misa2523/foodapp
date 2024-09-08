class HomeFood < ApplicationRecord

  #アソシエーション
  belongs_to :customer
  belongs_to :genre
  has_many :notifications, dependent: :destroy

  #バリデーション設定
  validates :name, uniqueness: true, presence: true #同じ食材を別々で登録しないため一意性を設定
  validates :amount, presence: true

end
