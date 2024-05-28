require 'rails_helper'

RSpec.describe Customer, type: :model do
  let!(:customer) { build(:customer, document: 'invalid') }
  let!(:active_customer) { create(:customer) }
  let!(:inactive_customer) { create(:customer, active: false) }
  let!(:sale) { build(:sale, customer: active_customer) }

  describe 'associations' do
    it { should have_many(:sales) }
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:phones).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:email) }
    it { should allow_value('john@example.com').for(:email) }
    it { should_not allow_value('johnexample.com').for(:email) }

    it 'validates the format of document' do
      customer.valid?
      expect(customer.errors[:document]).to include('precisa ser um CPF ou CNPJ válido')
    end
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:addresses) }
    it { should accept_nested_attributes_for(:phones) }
  end

  describe 'scopes' do
    describe '.active' do
      it 'returns active customers' do
        expect(Customer.actives).to include(active_customer)
        expect(Customer.actives).not_to include(inactive_customer)
      end
    end
  end

  describe '#activate!' do
    it 'activates the customer' do
      inactive_customer.activate!
      expect(customer.active).to eq(true)
    end
  end

  describe '#deactivate!' do
    it 'deactivates the customer and cancels sales' do
      sale.save!
      active_customer.deactivate!

      expect(active_customer.active).to eq(false)
      expect(sale.reload.status).to eq('canceled')
    end

    it 'adds errors if deactivation fails' do
      allow(active_customer).to receive(:update!).and_raise('Something went wrong')

      active_customer.deactivate!
      expect(active_customer.errors[:base]).to include('Failed to deactivate customer or cancel sales: Something went wrong')
    end
  end
end
