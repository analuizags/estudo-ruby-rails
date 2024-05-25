class Address < ApplicationRecord
  belongs_to :customer, inverse_of: :addresses

  validates :street, :number, :district, :city, :state, presence: true
  validates :zipcode, presence: true, format: { with: /\A\d{8}\z/, message: "must have 8 digits" }
end
