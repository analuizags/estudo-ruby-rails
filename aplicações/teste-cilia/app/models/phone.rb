class Phone < ApplicationRecord
  belongs_to :customer, inverse_of: :phones

  validates :ddd, presence: true, format: { with: /\A\d{2}\z/, message: "deve ter 2 dígitos" }
  validates :number, presence: true, format: { with: /\A\d{8,9}\z/, message: "deve ter de 8 a 9 dígitos" }

  before_destroy :validate_customer_has_more_than_one_phone

  private

  def validate_customer_has_more_than_one_phone
    if customer && customer.phones.count <= 1
      errors.add(:base, "Cliente precisa ter pelo menos 1 telefone")
      throw(:abort)
    end
  end
end
