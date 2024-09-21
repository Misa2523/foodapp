class HomeFood < ApplicationRecord

  #アソシエーション
  belongs_to :customer
  belongs_to :genre
  has_many :notifications, dependent: :destroy

  #バリデーション設定
  validates :name, uniqueness: true, presence: true #同じ食材を別々で登録しないため一意性を設定
  validates :amount, presence: true

  before_validation :strip_whitespace #private内のメソッド呼び出し

  #ソート機能   「scopeメソッド」scope :スコープの名前, -> { 条件式 }     /order：データの取り出し 
  scope :expiration_soon, -> {order(expiration_date: :asc)} #消費期限が早い順に並べる
  scope :best_before_soon, -> {order(best_before_date: :asc)} #賞味期限が早い順に並べる
  scope :created_old, -> {order(created_at: :asc)} #登録日が古い順に並べる

  private

  #名前の前後の空白を自動で削除する
  def strip_whitespace
    self.name = name.strip unless name.nil?
  end

end
