require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:active_product) { create(:product) }
  let!(:inactive_product) { create(:product, active: false) }
  let!(:sale_product) {  create(:sale_product, product: active_product) }

  describe 'associations' do
    it { should have_many(:sale_products) }
    it { should have_many(:sales).through(:sale_products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:image) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  describe '#activate!' do
    it 'activates the product' do
      inactive_product.activate!
      expect(inactive_product.active).to eq(true)
    end
  end

  describe '#deactivate!' do
    it 'deactivates the product and destroys associated sale products' do
      active_product.deactivate!
      expect(active_product.active).to eq(false)
      expect(SaleProduct.exists?(sale_product.id)).to be_falsey
    end

    it 'adds errors if deactivation fails' do
      allow(active_product).to receive(:update!).and_raise('Algo deu errado')
      active_product.deactivate!
      expect(active_product.errors[:base]).to include('Falha ao desativar o produto ou cancelar a venda do produto: Algo deu errado')
    end
  end
end
