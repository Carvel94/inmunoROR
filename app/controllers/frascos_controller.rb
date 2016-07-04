class FrascosController < ApplicationController
  before_action :set_frasco, only: [:show, :edit, :update, :destroy]

  # GET /frascos
  # GET /frascos.json


  def index
    @frascos = []
    @users = Usuario.select("id,nombre,apellido,frascos").where(rol:3)
    @users.each do |usr|
  end

  # GET /frascos/1
  # GET /frascos/1.json
  def show

  end

  # GET /frascos/new
  def new
    @frasco = Frasco.new
  end

  # GET /frascos/1/edit
  def edit
  end

  # POST /frascos
  # POST /frascos.json
  def create

    @frasco = Frasco.new(frasco_params)

    respond_to do |format|
      if @frasco.save
        format.html { redirect_to @frasco, notice: 'Frasco was successfully created.' }
        format.json { render :show, status: :created, location: @frasco }
      else
        format.html { render :new }
        format.json { render json: @frasco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /frascos/1
  # PATCH/PUT /frascos/1.json
  def update
    respond_to do |format|
      if @frasco.update(frasco_params)
        format.html { redirect_to @frasco, notice: 'Frasco was successfully updated.' }
        format.json { render :show, status: :ok, location: @frasco }
      else
        format.html { render :edit }
        format.json { render json: @frasco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frascos/1
  # DELETE /frascos/1.json
  def destroy
    @frasco.destroy
    respond_to do |format|
      format.html { redirect_to frascos_url, notice: 'Frasco was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_frasco
      @frasco = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def frasco_params
      params.fetch(:frasco, {})
    end
end
