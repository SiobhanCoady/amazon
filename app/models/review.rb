class Review < ApplicationRecord
  belongs_to :product

  validates :rating, inclusion: 1..5
end
