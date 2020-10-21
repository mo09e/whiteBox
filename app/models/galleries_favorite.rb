class GalleriesFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :gallery
  validates :user_id, uniqueness: { scope: :gallery_id }
end
