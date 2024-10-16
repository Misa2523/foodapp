class HomeFood < ApplicationRecord

  #アソシエーション
  belongs_to :customer
  belongs_to :genre
  has_many :notifications, dependent: :destroy

  #バリデーション設定
  validates :name, uniqueness: { scope: :customer_id },  #同じ食材を別々で登録しないため一意性を設定(登録者が同一でない場合は登録できるようscopeを設定)
                  presence: true
  validates :amount, presence: true

  before_validation :strip_whitespace #private内のメソッド呼び出し

  #ソート機能   「scopeメソッド」scope :スコープの名前, -> { 条件式 }     /order：データの取り出し
  scope :expiration_soon, -> { #消費期限が早い順に並べる
    order(Arel.sql("CASE WHEN expiration_date IS NULL THEN 1 ELSE 0 END, expiration_date ASC")) # Arel.sqlを使いCASE文を組むことで、日付設定されないデータ(NULL値)を後ろに表示
  }
  scope :best_before_soon, -> { #賞味期限が早い順に並べる
    order(Arel.sql("CASE WHEN best_before_date IS NULL THEN 1 ELSE 0 END, best_before_date ASC"))
  }
  scope :created_old, -> { #登録日が古い順に並べる
    order(created_at: :asc)
  }
    #--ソート機能のコード解説--#
  # Arel.sql("CASE WHEN [カラム名] IS NULL THEN 1 ELSE 0 END")の部分 ====> [カラム名]がNULLの場合1を返し、それ以外の場合は0を返す

  #通知機能
  #消費期限の残り日数を計算するメソッド
  def remaining_expiration_days
    return nil unless expiration_date.present? #消費期限がない場合はnil
    (expiration_date - Date.today).to_i
  end
  #賞味期限の残り日数を計算するメソッド
  def remaining_best_before_days
    return nil unless best_before_date.present?
    (best_before_date - Date.today).to_i
  end

  private

  #名前の前後の空白を自動で削除する
  def strip_whitespace
    self.name = name.strip unless name.nil?
  end

end
