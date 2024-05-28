class AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_address, only: %i[ show edit update destroy ]

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.where(customer_id: current_customer.id)
  end

  # GET /addresses/1 or /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses or /addresses.json
  def create
    @address = Address.new(address_params)
    @address.customer = current_customer

    respond_to do |format|
      if @address.save
        format.html { redirect_to address_url(@address), notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to address_url(@address), notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    respond_to do |format|
      if @address.destroy
        format.html { redirect_to addresses_url, notice: "Address was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to addresses_url, alert: @address.errors.full_messages.join('. ')}
        format.json { head :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:street, :number, :district, :city, :state, :zipcode, :customer_id)
    end
end
