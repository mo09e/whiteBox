class Gallery < ApplicationRecord
  belongs_to :user
  enum rental_fee: { within10000yen: 0, as10000to30000yen: 1, as30000to50000yen: 2, over50000yen: 3 }
  # enum rental_fee: { a: 0, b: 1, c: 2, d: 3 }
  # enum lending_period: { 1日: 0, 3日間: 1, 5日間: 2, 7日間: 3, その他: 4 }

  mount_uploaders :images, GalleryImageUploader
  mount_uploader :layout, GalleryImageUploader
end
