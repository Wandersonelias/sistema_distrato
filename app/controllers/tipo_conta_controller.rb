class TipoContaController < ApplicationController
  before_action :set_tipo_contum, only: [:show, :edit, :update, :destroy]

  # GET /tipo_conta
  # GET /tipo_conta.json
  def index
    @tipo_conta = TipoContum.all
  end

  # GET /tipo_conta/1
  # GET /tipo_conta/1.json
  def show
  end

  # GET /tipo_conta/new
  def new
    @tipo_contum = TipoContum.new
  end

  # GET /tipo_conta/1/edit
  def edit
  end

  # POST /tipo_conta
  # POST /tipo_conta.json
  def create
    @tipo_contum = TipoContum.new(tipo_contum_params)

    respond_to do |format|
      if @tipo_contum.save
        format.html { redirect_to @tipo_contum, notice: 'Tipo contum was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_contum }
      else
        format.html { render :new }
        format.json { render json: @tipo_contum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_conta/1
  # PATCH/PUT /tipo_conta/1.json
  def update
    respond_to do |format|
      if @tipo_contum.update(tipo_contum_params)
        format.html { redirect_to @tipo_contum, notice: 'Tipo contum was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_contum }
      else
        format.html { render :edit }
        format.json { render json: @tipo_contum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_conta/1
  # DELETE /tipo_conta/1.json
  def destroy
    @tipo_contum.destroy
    respond_to do |format|
      format.html { redirect_to tipo_conta_url, notice: 'Tipo contum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_contum
      @tipo_contum = TipoContum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_contum_params
      params.require(:tipo_contum).permit(:descricao)
    end
end
