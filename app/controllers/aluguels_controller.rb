class AluguelsController < ApplicationController
  before_action :set_aluguel, only: [:show, :edit, :update, :destroy]

  # GET /aluguels
  # GET /aluguels.json
  def index
    @aluguels = Aluguel.all
  end

  # GET /aluguels/1
  # GET /aluguels/1.json
  def show
  end

  # GET /aluguels/new
  def new
    @aluguel = Aluguel.new
    
  end

  # GET /aluguels/1/edit
  def edit
  end

  # POST /aluguels
  # POST /aluguels.json
  def create
    @aluguel = Aluguel.new(aluguel_params)
    
    vencimeto = DateTime.parse(@aluguel.data_vencimento) + 5
    previsao = DateTime.parse(@aluguel.previsao_pagamento)
    result_mora = previsao.mday - vencimeto.mday

    puts "-------------------------------------------"
    puts vencimeto 
    puts "-------------------------------------------"


    puts "Resultado de mora #{result_mora.to_s}"

    if vencimeto < previsao
      puts "É maior"
      valor = @aluguel.valor_aluguel
      @aluguel.multa = ((valor * 10 ) / 100) + valor
      @aluguel.juros = ((((valor / 30) * 1) /100) * result_mora) + @aluguel.multa
    else
      @aluguel.multa = 0.00
      @aluguel.juros = 0.00
    end

    respond_to do |format|
      if @aluguel.save
        format.html { redirect_to entregas_path, notice: 'Aluguel foi criado com sucesso!.' }
        format.json { render :show, status: :created, location: @aluguel }
      else
        format.html { render :new }
        format.json { render json: @aluguel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aluguels/1
  # PATCH/PUT /aluguels/1.json
  def update
    respond_to do |format|
      if @aluguel.update(aluguel_params)
        format.html { redirect_to @aluguel, notice: 'Aluguel was successfully updated.' }
        format.json { render :show, status: :ok, location: @aluguel }
      else
        format.html { render :edit }
        format.json { render json: @aluguel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aluguels/1
  # DELETE /aluguels/1.json
  def destroy
    @aluguel.destroy
    respond_to do |format|
      format.html { redirect_to entregas_url, notice: 'Aluguel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aluguel
      @aluguel = Aluguel.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def aluguel_params
      params.require(:aluguel).permit(:entrega_id, :periodo, :data_vencimento, :previsao_pagamento, :valor_aluguel, :multa, :juros)
    end
end
