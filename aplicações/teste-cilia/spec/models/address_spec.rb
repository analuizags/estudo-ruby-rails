require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:customer) { create(:customer) }
  let(:address) { build(:address, customer: customer) }
  let(:another_address) { build(:address, customer: customer) }

  describe 'validations' do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:district) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }

    it 'validates the format of zipcode' do
      address.zipcode = '1234567'
      expect(address).not_to be_valid
      expect(address.errors[:zipcode]).to include('deve ter 8 dígitos')

      address.zipcode = '12345678'
      expect(address).to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:customer) }
  end

  describe 'callbacks' do
    context 'before_destroy' do
      it 'does not allow destroying the only address of a customer' do
        address.save!
        address.destroy

        expect(address.errors[:base]).to include('Cliente precisa ter pelo menos 1 endereço')
      end

      it 'allows destroying if customer has more than one address' do
        address.save!
        another_address.save!
        address.destroy

        expect(address.errors).to be_empty
      end
    end
  end
end
