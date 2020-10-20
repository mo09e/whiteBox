class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :gallery

  validates :user_id, uniqueness: { scope: :artist_id, :gallery_id }
end
