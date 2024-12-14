class Seller < ApplicationRecord
  has_many :products, dependent: :nullify
  validates :name, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, allow_nil: true
end
  