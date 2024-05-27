class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  has_many :sales
  has_many :addresses, inverse_of: :customer, dependent: :destroy
  has_many :phones, inverse_of: :customer, dependent: :destroy

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :phones

  validates :name, :document, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  validate :valid_document

  def activate!
    update!(active: true)
  end

  def deactivate!
    ActiveRecord::Base.transaction do
      update!(active: false)
      sales&.each(&:cancel!)
    end
  rescue => e
    errors.add(:base, "Failed to deactivate customer or cancel sales: #{e.message}")
    false
  end

  private

  def valid_document
    unless CPF.valid?(document) || CNPJ.valid?(document)
      errors.add(:document, "must be a valid CPF or CNPJ")
    end
  end
end
