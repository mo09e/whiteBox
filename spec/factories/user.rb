FactoryBot.define do
  factory :artist_user, class: User do
    name { 'a-test_name' }
    email { 'a-test@ex.com' }
    password { 'password' }
    password_confirmation { 'password' }
    avatar { 'app/assets/images/fallback/default_avatar.png' }
    gallery_owner { false }
    admin { false }
  end
  factory :gallery_user, class: User do
    name { 'g-test_name' }
    email { 'g-test@ex.com' }
    password { 'password' }
    password_confirmation { 'password' }
    avatar { 'app/assets/images/fallback/default_avatar.png' }
    gallery_owner { true }
    admin { false }
  end
  factory :admin_user, class: User do
    name { 'admin' }
    email { 'admin@ex.com' }
    password { 'password' }
    password_confirmation { 'password' }
    avatar { 'app/assets/images/fallback/default_avatar.png' }
    gallery_owner { false }
    admin { true }
  end

  factory :artist_user_info, class: Artist do
    name { 'Hamlet' }
    phone_number { '0123456789' }
    url { 'http://testtest.test.com' }
    note { 'Brevity is the soul of wit.' }
    images { ['app/assets/images/fallback/default.png'] }
    user_id { User.find_by(gallery_owner: false).id }
  end

  factory :gallery_user_info, class: Gallery do
    name { 'Macbeth' }
    phone_number { '0123456789' }
    address { '東京都三鷹市' }
    rental_fee { 2 }
    lending_period { 1 }
    url { 'http://testtest.test.com' }
    layout { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png')) }
    images { ['app/assets/images/gallery-w.jpg'] }
    note { 'Life is but a walking shadow.' }
    user_id { User.find_by(gallery_owner: true).id }
  end
end
