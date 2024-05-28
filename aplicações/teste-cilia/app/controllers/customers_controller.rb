class CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :activate]
  before_action :authenticate_admin!, only: [:index, :activate]
  before_action :set_customer, only: %i[ show edit update activate deactivate ]

  # GET /customers or /customers.json
  def index
    @customers = filter_customers.order(active: :desc, name: :asc)
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/1/edit
  def edit
    @customer.addresses.build if @customer.addresses.empty?
    @customer.phones.build if @customer.phones.empty?
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def activate
    @customer.activate!
    respond_to do |format|
      format.html { redirect_to customers_path, notice: 'Customer was successfully activated.' }
      format.json { render :show, status: :ok, location: @customer }
    end
  end

  def deactivate
    respond_to do |format|
      if @customer.deactivate!
        format.html { redirect_to customers_path, notice: 'Customer was successfully disabled.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { redirect_to customers_path, alert: @customer.errors.full_messages.join('. ') }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(
        :name,
        :document,
        :birthdate,
        addresses_attributes: [:id, :street, :number, :district, :city, :state, :zipcode],
        phones_attributes: [:id, :ddd, :number])
    end

    def filter_customers
      finder = CustomersFinder.new(
        params: params.permit(:name, :email, :active).to_hash,
        init_collection: Customer.all
      )

      finder.execute
    end
end
