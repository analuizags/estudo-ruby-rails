require 'rails_helper'

RSpec.describe PhonesController, type: :controller do
  let(:customer) { create(:customer) }
  let(:phone) { create(:phone, customer: customer) }

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
      get :show, params: { id: phone.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: phone.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Phone" do
        expect {
          post :create, params: { phone: FactoryBot.attributes_for(:phone) }
        }.to change(Phone, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Phone" do
        expect {
          post :create, params: { phone: FactoryBot.attributes_for(:phone, number: nil) }
        }.to_not change(Phone, :count)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the requested phone" do
        patch :update, params: { id: phone.to_param, phone: { number: "12345678" } }
        phone.reload
        expect(phone.number.to_s).to eq("12345678")
      end
    end

    context "with invalid parameters" do
      it "does not update the requested phone" do
        patch :update, params: { id: phone.to_param, phone: { number: "invalid" } }
        phone.reload
        expect(phone.number).not_to eq("invalid")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:another_phone) { create(:phone, customer: phone.customer) }

    it "destroys the requested phone" do
      expect {
        delete :destroy, params: { id: phone.to_param }
      }.to change(Phone, :count).by(-1)
    end
  end
end
