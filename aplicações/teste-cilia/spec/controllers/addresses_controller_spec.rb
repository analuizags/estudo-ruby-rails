require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:customer) { create(:customer) }
  let(:address) { create(:address, customer: customer) }

  before do
    sign_in customer
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: address.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: address.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Address" do
        expect {
          post :create, params: { address: FactoryBot.attributes_for(:address) }
        }.to change(Address, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Address" do
        expect {
          post :create, params: { address: FactoryBot.attributes_for(:address, street: nil) }
        }.to_not change(Address, :count)
      end
    end
  end

  describe "PATCH #update" do
    let(:address) { FactoryBot.create(:address) }

    context "with valid parameters" do
      it "updates the requested address" do
        patch :update, params: { id: address.to_param, address: { street: "New Street" } }
        address.reload
        expect(address.street).to eq("New Street")
      end
    end

    context "with invalid parameters" do
      it "does not update the requested address" do
        patch :update, params: { id: address.to_param, address: { street: nil } }
        address.reload
        expect(address.street).not_to eq(nil)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:another_address) { create(:address, customer: address.customer) }

    it "destroys the requested address" do
      expect {
        delete :destroy, params: { id: address.to_param }
      }.to change(Address, :count).by(-1)
    end
  end
end
