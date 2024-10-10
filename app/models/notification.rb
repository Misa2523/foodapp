# class Notification < ApplicationRecord

#   #アソシエーション
#   belongs_to :customer
#   belongs_to :home_food

#   #バリデーション設定
#   validates :message, presence: true
#   validates :notification_type, presence: true

# end








class Notification < ApplicationRecord

  #アソシエーション
  belongs_to :customer
  belongs_to :home_food   #消す？

  #ポリモーフィック関連を持たせる。このモデルが通知を表し、どの食材に関連する通知かを柔軟に扱えるようにする
  belongs_to :notifiable, polymorphic: true

  #バリデーション設定
  validates :message, presence: true
  validates :notification_type, presence: true

end