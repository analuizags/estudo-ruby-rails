class Address < ApplicationRecord
  belongs_to :customer, inverse_of: :addresses

  validates :street, :number, :district, :city, :state, presence: true
  validates :zipcode, presence: true, format: { with: /\A\d{8}\z/, message: "must have 8 digits" }

  before_destroy :validate_customer_has_more_than_one_address

  private

  def validate_customer_has_more_than_one_address
    if customer && customer.addresses.count <= 1
      errors.add(:base, "Cliente precisa ter pelo menos 1 endereço")
      throw(:abort)
    end
  end
end
