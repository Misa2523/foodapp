class CookingPost < ApplicationRecord

  #アソシエーション
  belongs_to :customer

  has_one_attached :cooking_post_image

  #バリデーション設定
  validates :name, presence: true
  validates :introduction, presence: true

  #画像の設定メソッド
  def get_cooking_post_image(width, height)
    unless cooking_post_image.attached? #投稿に画像がない場合
      file_path = Rails.root.join('app/asets/images/o_image.jpg') #()内へのルートパス作成
      cooking_post_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg') #imageに画像を代入
    end
    cooking_post_image.variant(resize_to_fill: [width, height]).processed #指定された幅と高さにリサイズされたデフォルト画像が代入されたcooking_post_imageを返す
  end

end
