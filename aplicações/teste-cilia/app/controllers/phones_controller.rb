class PhonesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_phone, only: %i[ show edit update destroy ]

  # GET /phones or /phones.json
  def index
    @phones = Phone.where(customer_id: current_customer.id)
  end

  # GET /phones/1 or /phones/1.json
  def show
  end

  # GET /phones/new
  def new
    @phone = Phone.new
  end

  # GET /phones/1/edit
  def edit
  end

  # POST /phones or /phones.json
  def create
    @phone = Phone.new(phone_params)
    @phone.customer = current_customer

    respond_to do |format|
      if @phone.save
        format.html { redirect_to phone_url(@phone), notice: "O telefone foi criado com sucesso." }
        format.json { render :show, status: :created, location: @phone }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phones/1 or /phones/1.json
  def update
    respond_to do |format|
      if @phone.update(phone_params)
        format.html { redirect_to phone_url(@phone), notice: "O telefone foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @phone }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phones/1 or /phones/1.json
  def destroy
    respond_to do |format|
      if @phone.destroy
        format.html { redirect_to phones_url, notice: "O telefone foi excluído com sucesso." }
        format.json { head :no_content }
      else
        format.html { redirect_to phones_url, alert: @phone.errors.full_messages.join(". ") }
        format.json { head :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone
      @phone = Phone.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def phone_params
      params.require(:phone).permit(:ddd, :number, :customer_id)
    end
end
