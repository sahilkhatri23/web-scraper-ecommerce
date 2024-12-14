class Product < ApplicationRecord
  belongs_to :category
  belongs_to :seller, optional: true

  has_many_attached :images
end
