class SalesController < ApplicationController
  before_action :authenticate_admin!, only: [:index_admin, :show_admin, :cancel_admin, :complete]
  before_action :authenticate_customer!, except: [:index_admin, :show_admin, :cancel_admin, :complete]
  before_action :set_sale, only: [:show, :edit, :update, :cancel, :complete, :show_admin, :cancel_admin]
  before_action :check_status, only: [:edit, :update]

  # GET /sales or /sales.json
  def index
    @sales = Sale.where(customer_id: current_customer.id)
  end
  
  def index_admin
    @sales = filter_sales
    @customers = Customer.all

    render :index
  end

  # GET /sales/1 or /sales/1.json
  def show
  end

  def show_admin
    render :show
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
        format.html { redirect_to sale_url(@sale), notice: "A venda foi criada com sucesso." }
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
        format.html { redirect_to sale_url(@sale), notice: "A venda foi atualizada com sucesso." }
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
      redirect_to index_admin_sales_path, notice: "A venda foi concluída com sucesso."
    rescue AASM::InvalidTransition
      redirect_to index_admin_sales_path, alert: "A venda não pode ser concluída a partir do seu estado atual."
    end
  end

  def cancel
    begin
      @sale.cancel!
      redirect_to sales_url, notice: "A venda foi cancelada com sucesso."
    rescue AASM::InvalidTransition
      redirect_to sales_url, alert: "A venda não pode ser cancelada em seu estado atual."
    end
  end

  def cancel_admin
    begin
      @sale.cancel!
      redirect_to index_admin_sales_path, notice: "A venda foi cancelada com sucesso."
    rescue AASM::InvalidTransition
      redirect_to index_admin_sales_path, alert: "A venda não pode ser cancelada em seu estado atual."
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
          format.html { redirect_to sales_url, alert: "A venda só poderá ser editada se estiver pendente." }
          format.json { redirect_to sales_url, status: :unprocessable_entity }
        end
      end
    end

    def filter_sales
      finder = SalesFinder.new(
        params: params.permit(:customer_id, :status).to_hash,
        init_collection: Sale.all
      )

      finder.execute
    end
end
