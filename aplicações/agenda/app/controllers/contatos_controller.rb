class ContatosController < ApplicationController
  before_action :set_contato, only: [:show, :edit, :update, :destroy]
  before_action :set_opcoes_tipo, only: [:new, :edit, :update, :create]

  # GET /contatos
  # GET /contatos.json
  def index
    @contatos = Contato.order(:nome).page(params[:page]).per(15)
  end

  # GET /contatos/1
  # GET /contatos/1.json
  def show
  end

  # GET /contatos/new
  def new
    @contato = Contato.new
    @contato.build_endereco
  end

  # GET /contatos/1/edit
  def edit
  end

  # POST /contatos
  # POST /contatos.json
  def create
    @contato = Contato.new(contato_params)

    respond_to do |format|
      if @contato.save
        format.html { redirect_to contatos_path, notice: I18n.t('message.created') }
        format.json { render :show, status: :created, location: @contato }
      else
        format.html { render :new }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contatos/1
  # PATCH/PUT /contatos/1.json
  def update
    respond_to do |format|
      if @contato.update(contato_params)
        format.html { redirect_to contatos_path, notice: I18n.t('message.updated') }
        format.json { render :show, status: :ok, location: @contato }
      else
        format.html { render :edit }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contatos/1
  # DELETE /contatos/1.json
  def destroy
    @contato.destroy
    respond_to do |format|
      format.html { redirect_to contatos_url, notice:  I18n.t('message.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    def set_opcoes_tipo
      @opcoes = Tipo.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_contato
      @contato = Contato.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contato_params
      params.require(:contato).permit(:nome, :email, :tipo_id, :observacao, 
        endereco_attributes: [:endereco, :cidade, :estado], 
        telefone_attributes: [:id, :ddd, :numero, :_destroy])
    end
end
