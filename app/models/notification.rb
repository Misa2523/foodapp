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

  #ポリモーフィック関連
  belongs_to :notifiable, polymorphic: true

  #バリデーション設定
  validates :message, presence: true
  validates :notification_type, presence: true

end