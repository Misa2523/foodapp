class Customer < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーション
  has_many :cooking_posts, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :home_foods, dependent: :destroy

  #バリデーション設定
  validates :name, presence: true
  validates :name_kana, presence: true
  validates :telephone_number, uniqueness: true, presence: true #uniqueness：一意性があるか

  def active_for_authentication? #有効会員かどうかを判断
    super && (self.is_active == true)
  end

end
