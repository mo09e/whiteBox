class Gallery < ApplicationRecord
  belongs_to :user

  mount_uploaders :images, GalleryImageUploader
  mount_uploader :layout, GalleryImageUploader
end
