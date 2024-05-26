class Sale < ApplicationRecord
  include AASM

  belongs_to :customer
  has_many :sale_products
  has_many :products, through: :sale_products

  accepts_nested_attributes_for :sale_products, allow_destroy: true, reject_if: proc { |attr| attr['quantity'].to_i.zero? }

  validates :status, presence: true, inclusion: { in: %w[pending completed canceled], message: "%{value} is not a valid status" }

  aasm column: 'status' do
    state :pending, initial: true
    state :completed
    state :canceled

    event :complete do
      transitions from: :pending, to: :completed
    end

    event :cancel do
      transitions from: :pending, to: :canceled
    end
  end
end
