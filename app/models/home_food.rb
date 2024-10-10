# class HomeFood < ApplicationRecord

#   #アソシエーション
#   belongs_to :customer
#   belongs_to :genre
#   has_many :notifications, dependent: :destroy

#   #バリデーション設定
#   validates :name, uniqueness: { scope: :customer_id },  #同じ食材を別々で登録しないため一意性を設定(登録者が同一でない場合は登録できるようscopeを設定)
#                   presence: true
#   validates :amount, presence: true

#   before_validation :strip_whitespace #private内のメソッド呼び出し

#   #ソート機能   「scopeメソッド」scope :スコープの名前, -> { 条件式 }     /order：データの取り出し
#   scope :expiration_soon, -> { #消費期限が早い順に並べる
#     order(Arel.sql("CASE WHEN expiration_date IS NULL THEN 1 ELSE 0 END, expiration_date ASC")) # Arel.sqlを使いCASE文を組むことで、日付設定されないデータ(NULL値)を後ろに表示
#   }
#   scope :best_before_soon, -> { #賞味期限が早い順に並べる
#     order(Arel.sql("CASE WHEN best_before_date IS NULL THEN 1 ELSE 0 END, best_before_date ASC"))
#   }
#   scope :created_old, -> { #登録日が古い順に並べる
#     order(created_at: :asc)
#   }
#     #--ソート機能のコード解説--#
#   # Arel.sql("CASE WHEN [カラム名] IS NULL THEN 1 ELSE 0 END")の部分 ====> [カラム名]がNULLの場合1を返し、それ以外の場合は0を返す

#   private

#   #名前の前後の空白を自動で削除する
#   def strip_whitespace
#     self.name = name.strip unless name.nil?
#   end

# end






class HomeFood < ApplicationRecord

  #アソシエーション
  belongs_to :customer
  belongs_to :genre

  has_many :notifications, dependent: :destroy     #消す？

  #ポリモーフィック関連（食材ごとに通知を作成できる）
  # has_many :notifications, as: :notifiable#, dependent: :destroy

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

  # #通知機能     消費期限が近い食材の通知を作成
  # def self.check_and_create_notifications  #コントローラでHomeFood.check_and_create_notificationsのようにクラスから直接呼び出せるようにするため、クラスメソッドとして定義（self.をつける）
  #   home_foods_near_expiry = HomeFood.where("expiration_date <= ?", Date.today + 3.days)
  #   home_foods_near_expiry.each do |home_food|
  #     home_food.notifications.create(message: "#{home_food.name}の期限が近づいています")
  #   end
  # end

  private

  #名前の前後の空白を自動で削除する
  def strip_whitespace
    self.name = name.strip unless name.nil?
  end

end