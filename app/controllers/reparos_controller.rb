class ReparosController < ApplicationController
  before_action :set_reparo, only: [:show, :edit, :update, :destroy]

  # GET /reparos
  # GET /reparos.json
  def index
    @reparos = Reparo.all
  end

  # GET /reparos/1
  # GET /reparos/1.json
  def show
  end

  # GET /reparos/new
  def new
    @reparo = Reparo.new
  end

  # GET /reparos/1/edit
  def edit
  end

  # POST /reparos
  # POST /reparos.json
  def create
    @reparo = Reparo.new(reparo_params)

    respond_to do |format|
      if @reparo.save
        format.html { redirect_to @reparo, notice: 'Reparo was successfully created.' }
        format.json { render :show, status: :created, location: @reparo }
      else
        format.html { render :new }
        format.json { render json: @reparo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reparos/1
  # PATCH/PUT /reparos/1.json
  def update
    respond_to do |format|
      if @reparo.update(reparo_params)
        format.html { redirect_to @reparo, notice: 'Reparo was successfully updated.' }
        format.json { render :show, status: :ok, location: @reparo }
      else
        format.html { render :edit }
        format.json { render json: @reparo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reparos/1
  # DELETE /reparos/1.json
  def destroy
    @reparo.destroy
    respond_to do |format|
      format.html { redirect_to reparos_url, notice: 'Reparo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reparo
      @reparo = Reparo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reparo_params
      params.require(:reparo).permit(:entrega_id, :descricao, :valor)
    end
end
