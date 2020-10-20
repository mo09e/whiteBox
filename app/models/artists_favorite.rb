class ArtistsFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  validates :user_id, uniqueness: { scope: :artist_id }
end
