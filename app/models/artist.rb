class Artist < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, ArtistImageUploader

  validates :name, presence: true, length: { maximum: 50 }
  validates :phone_number,
                          format: { with: /\A\d{10,11}\z/ , message: "電話番号はハイフン無し、11桁以内でご入力をお願いします" },
                          allow_blank: true
  validates :url, format: { with: /\A#{URI::regexp(%w(http https))}\z/, message: "このURLでは無効です。" },
                  allow_blank: true
  validates :note, presence: true, length: { maximum: 800 }
  validate :check_image, :check_image_limit
  def check_image
    if images.count == 0
      errors.add(:images, "作品画像は最低１枚登録してください。")
    end
  end

  def check_image_limit
    if images.count > 5
      errors.add(:images, "画像投稿数は最大５個です。")
    end
  end
end
