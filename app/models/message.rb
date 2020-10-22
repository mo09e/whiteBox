class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :content, presence: true, length: { maximum: 200 }
end
