class ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_product, only: %i[ show edit update activate deactivate ]

  # GET /products or /products.json
  def index
    @products = filter_products.order(active: :desc, name: :asc)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "O produto foi criado com sucesso." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "O produto foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def activate
    @product.activate!
    respond_to do |format|
      format.html { redirect_to products_path, notice: "O produto foi ativado com sucesso." }
      format.json { render :show, status: :ok, location: @product }
    end
  end

  def deactivate
    respond_to do |format|
      if @product.deactivate!
        format.html { redirect_to products_path, notice: "O produto foi desativado com sucesso." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { redirect_to products_path, alert: @product.errors.full_messages.join(". ") }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :image)
    end

    def filter_products
      finder = ProductsFinder.new(
        params: params.permit(:name, :active).to_hash,
        init_collection: Product.all
      )

      finder.execute
    end
end
