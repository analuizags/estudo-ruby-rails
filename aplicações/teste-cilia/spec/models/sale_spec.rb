require 'rails_helper'

RSpec.describe Sale, type: :model do
  let(:sale) { create(:sale) }

  describe 'associations' do
    it { should belong_to(:customer) }
    it { should have_many(:sale_products) }
    it { should have_many(:products).through(:sale_products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'aasm state machine' do
    it 'initializes with pending state' do
      expect(sale.status).to eq('pending')
    end

    it 'transitions to completed state' do
      sale.complete!
      expect(sale.status).to eq('completed')
    end

    it 'transitions to canceled state' do
      sale.cancel!
      expect(sale.status).to eq('canceled')
    end
  end

  describe '#total_price' do
    let(:product1) { create(:product, price: 10) }
    let(:product2) { create(:product, price: 20) }

    before do
      sale.sale_products&.destroy_all
      create(:sale_product, sale: sale, product: product1, quantity: 2)
      create(:sale_product, sale: sale, product: product2, quantity: 3)
    end

    it 'calculates the total price of all sale products' do
      expect(sale.total_price).to eq((2 * product1.price) + (3 * product2.price))
    end
  end
end
