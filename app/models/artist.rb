class Artist < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  mount_uploaders :images, ArtistImageUploader
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :phone_number,
                          format: { with: /\A\d{10,11}\z/ , message: "電話番号はハイフン無し、11桁以内でご入力をお願いします" },
                          allow_blank: true
  validates :url, format: { with: /\A#{URI::regexp(%w(http https))}\z/, message: "このURLでは無効です。" },
                  allow_blank: true
  validates :note, presence: true, length: { maximum: 800 }
  validate :check_image_limit

  def check_image_limit
    if images.count > 5
      errors.add(:images, "画像投稿数は最大５個です。")
    end
  end
end
