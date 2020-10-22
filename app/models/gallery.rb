class Gallery < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :labeling, dependent: :destroy
  has_many :label, through: :labeling, dependent: :destroy
  has_many :galleries_favorites, dependent: :destroy
  has_many :favorite_users, through: :galleries_favorites, source: :user
  belongs_to :user, dependent: :destroy

  enum rental_fee: { within10000yen: 0, case10000to30000yen: 1, case30000to50000yen: 2, over50000yen: 3 }
  enum lending_period: { one_day: 0, every_three_days: 1, every_five_days: 2, every_seven_days: 3, etc: 4 }

  mount_uploaders :images, GalleryImageUploader
  mount_uploader :layout, GalleryImageUploader

  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 300 }
  validates :phone_number,
                          format: { with: /\A\d{10,11}\z/ , message: "電話番号はハイフン無し、10桁または11桁でご入力をお願いします" },
                          allow_blank: true
  validates :url, format: { with: /\A#{URI::regexp(%w(http https))}\z/, message: "このURLでは無効です。" },
                  allow_blank: true
  validates :note, presence: true, length: { maximum: 800 }
  validates :layout, presence: true
  validate :check_image_limit

  def check_image_limit
    if images.count > 5
      errors.add(:images, "画像投稿数は最大５個です。")
    end
  end
end
