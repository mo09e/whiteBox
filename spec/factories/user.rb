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
  factory :gallery_second_user, class: User do
    name { 'g-test2' }
    email { 'g-test2@ex.com' }
    password { 'password' }
    password_confirmation { 'password' }
    avatar { 'app/assets/images/fallback/default_avatar.png' }
    gallery_owner { true }
    admin { false }
  end
  factory :gallery_third_user, class: User do
    name { 'g-test3' }
    email { 'g-test3@ex.com' }
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
    images { [] }
    note { 'Life is but a walking shadow.' }
    user_id { User.find_by(gallery_owner: true).id }
  end
  factory :gallery_user_second_info, class: Gallery do
    name { 'julius' }
    phone_number { '0123456789' }
    address { '東京都江東区' }
    rental_fee { 3 }
    lending_period { 3 }
    url { 'http://testtest.test.com' }
    layout { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png')) }
    images { [] }
    note { 'And you, Brutus' }
    user_id { User.find_by(name: "g-test2").id }
  end
  factory :gallery_user_third_info, class: Gallery do
    name { 'King Lear' }
    phone_number { '0123456789' }
    address { '東京都八王子市' }
    rental_fee { 0 }
    lending_period { 2 }
    url { 'http://testtest.test.com' }
    layout { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png')) }
    images { [] }
    note { 'The worst is not, So long as we can say, This is the worst.' }
    user_id { User.find_by(name: "g-test3").id }
  end
end
