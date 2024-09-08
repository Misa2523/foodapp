class Customer < ApplicationRecord

  before_validation :normalize_email  #データが保存される前にprivateで定義したメソッドを実行

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
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } #標準的なメールアドレスの形式に対し十分なバリデーションを提供

  def active_for_authentication? #有効会員かどうかを判断
    super && (self.is_active == true)
  end

  private

  #emailの正規化処理
  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

end
