class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :galleries, through: :labelings
end
