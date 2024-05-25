class Sale < ApplicationRecord
  belongs_to :customer
  has_many :sale_products
  has_many :products, through: :sale_products

  accepts_nested_attributes_for :sale_products, allow_destroy: true

  validates :status, presence: true, inclusion: { in: %w[pending completed canceled], message: "%{value} is not a valid status" }
end
