require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:admin) { create(:admin) }
  let(:product) { create(:product) }

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Product" do
        expect {
          post :create, params: { product: FactoryBot.attributes_for(:product) }
        }.to change(Product, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Product" do
        expect {
          post :create, params: { product: FactoryBot.attributes_for(:product, name: nil) }
        }.to_not change(Product, :count)
      end
    end
  end

  describe "PATCH #update" do
    let(:product) { FactoryBot.create(:product) }

    context "with valid parameters" do
      it "updates the requested product" do
        patch :update, params: { id: product.to_param, product: { name: "New Name" } }
        product.reload
        expect(product.name).to eq("New Name")
      end
    end

    context "with invalid parameters" do
      it "does not update the requested product" do
        patch :update, params: { id: product.to_param, product: { name: nil } }
        product.reload
        expect(product.name).not_to eq(nil)
      end
    end
  end

  describe "PATCH #activate" do
    let!(:product) { create(:product, active: false) }

    it "activates the requested product" do
      patch :activate, params: { id: product.to_param }
      product.reload
      expect(product.active).to eq(true)
    end
  end

  describe "PATCH #deactivate" do
    let!(:product) { create(:product) }

    it "deactivates the requested product" do
      patch :deactivate, params: { id: product.to_param }
      product.reload
      expect(product.active).to eq(false)
    end
  end
end
