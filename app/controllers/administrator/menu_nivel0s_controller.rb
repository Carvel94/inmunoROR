class Administrator::MenuNivel0sController < ApplicationController
include CodigosGenerales

#la siguiente linea permite controlar que el usuario este logueado sino redirige a la 
#pagina de inicio de sessión 
before_filter :authenticate_usuario!

 before_action :cargarOpcionesDelPrincipal
  before_action :set_administrator_menu_nivel0, only: [:show, :edit, :update, :destroy]
  layout "administrator"
  
  # GET /administrator/menu_nivel0s
  # GET /administrator/menu_nivel0s.json
  def index
    @administrator_menu_nivel0s = Administrator::MenuNivel0.all
  end

  # GET /administrator/menu_nivel0s/1
  # GET /administrator/menu_nivel0s/1.json
  def show
  end

  # GET /administrator/menu_nivel0s/new
  def new
    @administrator_menu_nivel0 = Administrator::MenuNivel0.new
  end

  # GET /administrator/menu_nivel0s/1/edit
  def edit
  end

  # POST /administrator/menu_nivel0s
  # POST /administrator/menu_nivel0s.json
  def create

    @administrator_menu_nivel0 = Administrator::MenuNivel0.new(administrator_menu_nivel0_params)

    respond_to do |format|
      if @administrator_menu_nivel0.save
        format.html { redirect_to @administrator_menu_nivel0, notice: 'Menu nivel0 was successfully created.' }
        format.json { render :show, status: :created, location: @administrator_menu_nivel0 }
      else
        format.html { render :new }
        format.json { render json: @administrator_menu_nivel0.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administrator/menu_nivel0s/1
  # PATCH/PUT /administrator/menu_nivel0s/1.json
  def update
    respond_to do |format|
      if @administrator_menu_nivel0.update(administrator_menu_nivel0_params)
        format.html { redirect_to @administrator_menu_nivel0, notice: 'Menu nivel0 was successfully updated.' }
        format.json { render :show, status: :ok, location: @administrator_menu_nivel0 }
      else
        format.html { render :edit }
        format.json { render json: @administrator_menu_nivel0.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrator/menu_nivel0s/1
  # DELETE /administrator/menu_nivel0s/1.json
  def destroy
    @administrator_menu_nivel0.destroy
    respond_to do |format|
      format.html { redirect_to administrator_menu_nivel0s_url, notice: 'Menu nivel0 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator_menu_nivel0
      @administrator_menu_nivel0 = Administrator::MenuNivel0.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_menu_nivel0_params
       params.require(:administrator_menu_nivel0).permit(
                :titulo, :tipo, :estado, :posicion, :enlace,
                :titulo_contenido, :contenido, :menu0_id)
    end
end
