# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ↓ データベースに登録済み
# 管理者
Admin.create(email: 'sample@example.com', password: '1231025')
# 会員
customer = Customer.create!(
  name: '愛生江尾',
  name_kana: 'アイウエオ',
  email: 'aiueo111@email.com',
  telephone_number: '11111111111',
  password: 'aaiueo',
  password_confirmation: 'aaiueo',
  is_active: true
)
# ジャンル
genre = Genre.create(name: "肉・卵")