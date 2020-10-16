class Artist < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, ArtistImageUploader
end
