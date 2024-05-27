class SalesController < ApplicationController
  before_action :check_authenticate, except: [:new, :edit]
  before_action :authenticate_customer!, only: [:new, :edit]
  before_action :set_sale, only: [:show, :edit, :update, :destroy, :cancel, :complete]
  before_action :check_status, only: [:edit, :update]

  # GET /sales or /sales.json
  def index
    if admin_signed_in?
      @sales = Sale.all
    else
      @sales = Sale.where(customer_id: current_customer.id)
    end
  end

  # GET /sales/1 or /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new

    Product.all.each do |product|
      @sale.sale_products.build(product_id: product.id)
    end
  end

  # GET /sales/1/edit
  def edit
    Product.all.select { |product| !@sale.products.include?(product) }.each do |product|
      @sale.sale_products.build(product_id: product.id)
    end
  end

  # POST /sales or /sales.json
  def create
    @sale = Sale.new(sale_params)
    @sale.customer = current_customer
    @sale.status = "pending"

    respond_to do |format|
      if @sale.save
        format.html { redirect_to sale_url(@sale), notice: "Sale was successfully created." }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to sale_url(@sale), notice: "Sale was successfully updated." }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    begin
      @sale.complete!
      redirect_to sales_url, notice: 'Sale was successfully completed.'
    rescue AASM::InvalidTransition
      redirect_to sales_url, alert: 'Sale cannot be completed from its current state.'
    end
  end

  def cancel
    begin
      @sale.cancel!
      redirect_to sales_url, notice: 'Sale was successfully canceled.'
    rescue AASM::InvalidTransition
      redirect_to sales_url, alert: 'Sale cannot be canceled from its current state.'
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      params.require(:sale).permit(:customer_id, :status, sale_products_attributes: [:id, :product_id, :quantity, :_destroy])
    end

    def check_status
      unless @sale.pending?
        respond_to do |format|
          format.html { redirect_to sales_url, alert: "Sale can only be edited if it is pending." }
          format.json { redirect_to sales_url, status: :unprocessable_entity }
        end
      end
    end
end
