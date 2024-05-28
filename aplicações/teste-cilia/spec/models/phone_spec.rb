require 'rails_helper'

RSpec.describe Phone, type: :model do
  let(:customer) { create(:customer) }
  let(:phone) { build(:phone, customer: customer) }
  let(:another_phone) { build(:phone, customer: customer) }

  describe 'validations' do
    it { should validate_presence_of(:ddd) }
    it { should validate_presence_of(:number) }
    it { should allow_value('11').for(:ddd) }
    it { should_not allow_value('123').for(:ddd) }
    it { should allow_value('12345678').for(:number) }
    it { should allow_value('123456789').for(:number) }
    it { should_not allow_value('1234').for(:number) }
    it { should_not allow_value('1234567890').for(:number) }
  end

  describe 'associations' do
    it { should belong_to(:customer).inverse_of(:phones) }
  end

  describe 'callbacks' do
    describe 'before_destroy' do
      context 'when customer has more than one phone' do
        it 'allows destroying the phone' do
          phone.save!
          another_phone.save!
          phone.destroy

          expect { phone.destroy }.not_to change { Phone.count }
        end
      end

      context 'when customer has only one phone' do
        it 'does not allow destroying the phone' do
          phone.save!
          phone.destroy

          expect(phone.errors[:base]).to include('Cliente precisa ter pelo menos 1 telefone')
        end
      end
    end
  end
end
