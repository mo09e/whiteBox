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
             gallery_owner: false,
             admin: true
             )

#Artistユーザー
15.times do |n|
  name = Faker::Artist.name
  email = Faker::Internet.email
  password = "01pass23"
  User.create!(
               name: name,
               email: email,
               password: password,
               password_confirmation: password,
               avatar: File.open("./public/uploads/user/avatar/icon_avatar.png"),
               admin: false,
               gallery_owner: false
               )
end
users = User.where(gallery_owner: false)
users.each do |user|
  name = Faker::Artist.name
  Artist.create!(
     name: name,
     phone_number: "0123456789",
     url: "",
     images: [open("#{Rails.root}/public/uploads/artist/images/icon_a.png"),
              open("#{Rails.root}/public/uploads/artist/images/icon_b.png"),
              open("#{Rails.root}/public/uploads/artist/images/icon_c.png")],
     note: "test#ArtistUser",
     user_id: user.id)
end


#ギャラリー
15.times do |n|
  name = Faker::Music::GratefulDead.player
  email = Faker::Internet.email
  password = "01pass23"
  User.create!(
               name: name,
               email: email,
               password: password,
               password_confirmation: password,
               avatar: "",
               admin: false,
               gallery_owner: true
               )
end
users = User.where(gallery_owner: true)
users.each do |user|
  name = Faker::Book.title
  Gallery.create!(
     name: name,
     phone_number: "9876543210",
     address: "東京都中央区銀座",
     rental_fee: 2,
     lending_period: 2,
     url: "",
     images: [open("#{Rails.root}/public/uploads/gallery/images/icona.png"),
              open("#{Rails.root}/public/uploads/gallery/images/iconb.png"),
              open("#{Rails.root}/public/uploads/gallery/images/iconc.png")],
     layout: File.open("./public/uploads/gallery/layout/madori_ab.png"),
     note: "test#Gallery",
     user_id: user.id)
end
15.times do |n|
  Labeling.create!(
    gallery_id: Gallery.first.id + n,
    label_id: Label.first.id
  )
end

#予約機能
10.times do |n|
  title = Faker::Music::Opera.verdi
  Reservation.create!(
    start_time: Date.today.since(1.weeks),
    end_time: Date.today.since(2.weeks),
    title: title,
    artist_id: Artist.first.id + n,
    gallery_id: Gallery.first.id + n
  )
end
