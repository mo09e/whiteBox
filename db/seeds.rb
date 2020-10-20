# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 地区ラベル
Label.create!([
{ name: '銀座'},
{ name: '日本橋・京橋'},
{ name: '神田・御茶ノ水'},
{ name: '上野・浅草・浅草橋'},
{ name: '日暮里・千駄木'},
{ name: '飯田橋・早稲田'},
{ name: '青山・原宿'},
{ name: '新宿・四ツ谷'},
{ name: '渋谷'},
{ name: '恵比寿・目黒'},
{ name: '六本木・麻布・赤坂'},
{ name: '池袋'},
{ name: '下北沢・代々木上原'},
{ name: '自由が丘' },
{ name: '中野・高円寺・荻窪'},
{ name: '吉祥寺'},
{ name: 'その他東京（23区)'},
{ name: 'その他東京（23区外)'}
])

#admin ユーザー
User.create!(name: "AdminUser",
             email: "admin@example.com",
             password: 'pass0123',
             password_confirmation: 'pass0123',
             gallery_owner: 'false',
             admin: true
             )
