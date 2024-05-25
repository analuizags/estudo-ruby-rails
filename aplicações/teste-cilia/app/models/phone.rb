class Phone < ApplicationRecord
  belongs_to :customer, inverse_of: :phones

  validates :ddd, presence: true, format: { with: /\A\d{2}\z/, message: "must have 2 digits" }
  validates :number, presence: true, format: { with: /\A\d{8,9}\z/, message: "must have 8 to 9 digits" }
end
