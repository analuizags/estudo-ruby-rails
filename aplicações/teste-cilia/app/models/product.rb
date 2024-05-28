class Product < ApplicationRecord
  has_many :sale_products
  has_many :sales, through: :sale_products

  validates :name, :description, :price, :image, presence: true
  validates :price, numericality: { greater_than: 0 }

  mount_uploader :image, ImageUploader

  def activate!
    update!(active: true)
  end

  def deactivate!
    ActiveRecord::Base.transaction do
      update!(active: false)
      sale_products&.destroy_all
    end
  rescue => e
    errors.add(:base, "Falha ao desativar o produto ou cancelar a venda do produto: #{e.message}")
    false
  end
end
