class Customer < ApplicationRecord
  has_many :sales
  has_many :addresses, inverse_of: :customer, dependent: :destroy
  has_many :phones, inverse_of: :customer, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true

  validates :name, :document, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  validate :valid_document

  validates_associated :addresses
  validates_associated :phones

  private

  def valid_document
    unless CPF.valid?(document) || CNPJ.valid?(document)
      errors.add(:document, "must be a valid CPF or CNPJ")
    end
  end
end
