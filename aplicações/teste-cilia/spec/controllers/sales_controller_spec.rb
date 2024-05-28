require 'rails_helper'

RSpec.describe SalesController, type: :controller do
  let(:customer) { create(:customer) }
  let(:admin) { create(:admin) }
  let(:sale) { create(:sale, customer: customer, status: "pending") }
  let(:valid_attributes) { { status: "pending", sale_products_attributes: [{ product_id: create(:product).id, quantity: 1 }] } }

  describe "GET #index" do
    before { sign_in customer }

    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns the customer's sales as @sales" do
      get :index
      expect(assigns(:sales)).to eq([sale])
    end
  end

  describe "GET #index_admin" do
    before { sign_in admin }

    it "returns a success response" do
      get :index_admin
      expect(response).to be_successful
    end

    it "assigns all sales as @sales" do
      get :index_admin
      expect(assigns(:sales)).to include(sale)
    end
  end

  describe "GET #show" do
    before { sign_in customer }

    it "returns a success response" do
      get :show, params: { id: sale.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #show_admin" do
    before { sign_in admin }

    it "returns a success response" do
      get :show_admin, params: { id: sale.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    before { sign_in customer }

    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    before { sign_in customer }

    it "returns a success response" do
      get :edit, params: { id: sale.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    before { sign_in customer }

    context "with valid params" do
      it "creates a new Sale" do
        expect {
          post :create, params: { sale: valid_attributes }
        }.to change(Sale, :count).by(1)
      end

      it "redirects to the created sale" do
        post :create, params: { sale: valid_attributes }
        expect(response).to redirect_to(Sale.last)
      end
    end
  end

  describe "PATCH #update" do
    before { sign_in customer }

    context "with valid params" do
      let(:new_attributes) { { status: "completed" } }

      it "updates the requested sale" do
        patch :update, params: { id: sale.to_param, sale: new_attributes }
        sale.reload
        expect(sale.status).to eq("completed")
      end

      it "redirects to the sale" do
        patch :update, params: { id: sale.to_param, sale: new_attributes }
        expect(response).to redirect_to(sale)
      end
    end

    context "with invalid params" do
      it "renders the edit template" do
        patch :update, params: { id: sale.to_param, sale: { status: nil } }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #cancel" do
    before { sign_in customer }

    it "cancels the sale" do
      delete :cancel, params: { id: sale.to_param }
      sale.reload
      expect(sale.status).to eq("canceled")
    end

    it "redirects to the sales list" do
      delete :cancel, params: { id: sale.to_param }
      expect(response).to redirect_to(sales_url)
    end
  end

  describe "DELETE #cancel_admin" do
    before { sign_in admin }

    it "cancels the sale" do
      delete :cancel_admin, params: { id: sale.to_param }
      sale.reload
      expect(sale.status).to eq("canceled")
    end

    it "redirects to the admin sales list" do
      delete :cancel_admin, params: { id: sale.to_param }
      expect(response).to redirect_to(index_admin_sales_path)
    end
  end
end
