class Phone < ApplicationRecord
  belongs_to :customer, inverse_of: :phones

  validates :ddd, presence: true, format: { with: /\A\d{2}\z/, message: "must have 2 digits" }
  validates :number, presence: true, format: { with: /\A\d{8,9}\z/, message: "must have 8 to 9 digits" }

  before_destroy :validate_customer_has_more_than_one_phone

  private

  def validate_customer_has_more_than_one_phone
    if customer && customer.phones.count <= 1
      errors.add(:base, "Cliente precisa ter pelo menos 1 telefone")
      throw(:abort)
    end
  end
end
