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
  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }, #標準的なメールアドレスの形式に対し十分なバリデーションを提供
              unless: :guest? #ゲストログイン時はメールアドレスの一意性バリデーションを無効化（private内のメソッド実行）

  def active_for_authentication? #有効会員かどうかを判断
    super && (self.is_active == true)
  end

  #ゲストログイン機能
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |customer| #emailが記述と一致する顧客レコードをデータベースから検索し、なかったら新しく作成
      customer.password = SecureRandom.urlsafe_base64 #ランダムな文字列を生成
      customer.name = "ゲストユーザー"
      #バリデーションで全カラムに対し空白がNGとなっているため、以下も設定しておく
      customer.name_kana = "ゲストユーザー"
      customer.telephone_number = '00000000000'
      customer.password_confirmation = customer.password
      customer.is_active = true
    end
  end

  private

  #emailの正規化処理
  def normalize_email
    self.email = email.downcase.strip if email.present? #email属性が存在する場合、emailの値を小文字に変換し両端の空白を削除
  end

  #ゲストユーザーかどうか判断
  def guest?
    email == "guest@example.com"
  end

end
