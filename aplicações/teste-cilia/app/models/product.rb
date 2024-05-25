class Product < ApplicationRecord
  has_many :sale_products
  has_many :sales, through: :sale_products

  validates :name, :description, :price, :image, presence: true
end
