class HomeFood < ApplicationRecord

  #アソシエーション
  belongs_to :customer
  belongs_to :genre
  has_many :notifications, dependent: :destroy

  #バリデーション設定
  validates :name, uniqueness: true, presence: true #同じ食材を別々で登録しないため一意性を設定
  validates :amount, presence: true

  before_validation :strip_whitespace #private内のメソッド呼び出し

  private

  #名前の前後の空白を自動で削除する
  def strip_whitespace
    self.name = name.strip unless name.nil?
  end

end
