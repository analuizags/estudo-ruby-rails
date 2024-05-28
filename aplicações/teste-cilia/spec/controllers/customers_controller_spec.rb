require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:admin) { create(:admin) }
  let(:customer) { create(:customer) }

  describe "GET #index" do
    it "returns a success response for admin" do
      sign_in admin
      get :index
      expect(response).to be_successful
    end

    it "redirects to sign in for non-admin" do
      get :index
      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  describe "GET #show" do
    it "returns a success response for authenticated customer" do
      sign_in customer
      get :show, params: { id: customer.to_param }
      expect(response).to be_successful
    end

    it "redirects to sign in for unauthenticated user" do
      get :show, params: { id: customer.to_param }
      expect(response).to redirect_to(new_customer_session_path)
    end
  end

  describe "GET #edit" do
    it "returns a success response for authenticated customer" do
      sign_in customer
      get :edit, params: { id: customer.to_param }
      expect(response).to be_successful
    end

    it "redirects to sign in for unauthenticated user" do
      get :edit, params: { id: customer.to_param }
      expect(response).to redirect_to(new_customer_session_path)
    end
  end

  describe "PATCH #update" do
    let(:customer) { FactoryBot.create(:customer) }

    context "with valid parameters" do
      it "updates the requested customer for authenticated customer" do
        sign_in customer
        patch :update, params: { id: customer.to_param, customer: { name: "New Name" } }
        customer.reload
        expect(customer.name).to eq("New Name")
      end
    end

    context "with invalid parameters" do
      it "does not update the requested customer" do
        sign_in customer
        patch :update, params: { id: customer.to_param, customer: { name: nil } }
        customer.reload
        expect(customer.name).not_to eq(nil)
      end
    end

    it "redirects to sign in for unauthenticated user" do
      patch :update, params: { id: customer.to_param, customer: { name: "New Name" } }
      expect(response).to redirect_to(new_customer_session_path)
    end
  end

  describe "PATCH #activate" do
    let!(:customer) { FactoryBot.create(:customer) }

    it "activates the requested customer for admin" do
      sign_in admin
      patch :activate, params: { id: customer.to_param }
      customer.reload
      expect(customer.active).to eq(true)
    end

    it "redirects to sign in for non-admin" do
      patch :activate, params: { id: customer.to_param }
      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  describe "PATCH #deactivate" do
    let!(:customer) { FactoryBot.create(:customer, active: true) }

    it "activates the requested customer for customer" do
      sign_in customer
      patch :deactivate, params: { id: customer.to_param }
      customer.reload
      expect(customer.active).to eq(false)
    end

    it "redirects to sign in for non-customer" do
      patch :deactivate, params: { id: customer.to_param }
      expect(response).to redirect_to(new_customer_session_path)
    end
  end
end
