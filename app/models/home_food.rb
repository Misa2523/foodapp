class HomeFood < ApplicationRecord

  #アソシエーション
  belongs_to :customer
  belongs_to :genre
  has_many :notifications, dependent: :destroy

  #バリデーション設定
  validates :name, uniqueness: true, presence: true #同じ食材があったら内容をまとめるため一意性を設定
  validates :amount, presence: true

end
