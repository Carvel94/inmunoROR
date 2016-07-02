class Administrator::MenuNivel0::MenuNivel1sController < ApplicationController
  include CodigosGenerales

#la siguiente linea permite controlar que el usuario este logueado sino redirige a la 
#pagina de inicio de sessión 
 before_filter :authenticate_usuario!

 before_action :cargarOpcionesDelPrincipal
 
  before_action :set_administrator_menu_nivel0_menu_nivel1, only: [ :edit, :update, :destroy]
  layout "administrator"

  # GET /administrator/menu_nivel0/menu_nivel1s
  # GET /administrator/menu_nivel0/menu_nivel1s.json
  def index
    @opcionMenu = Administrator::MenuNivel0.find(params[:format])
    @administrator_menu_nivel0_menu_nivel1s = Administrator::MenuNivel0::MenuNivel1.where(administrator_menu_nivel0_id: params[:format]).order('posicion asc')
    if @administrator_menu_nivel0_menu_nivel1s.empty?
       flash.now[:warning] = "La opción principal de menu: #{@opcionMenu.titulo.sub("<br />", "")}, aún no tiene páginas asociadas" 
     end
  end

  # GET /administrator/menu_nivel0/menu_nivel1s/1
  # GET /administrator/menu_nivel0/menu_nivel1s/1.json

  def show
    @administrator_menu_nivel0_menu_nivel1 = Administrator::MenuNivel0::MenuNivel1.find(params[:id])
    @opcionMenu = Administrator::MenuNivel0.find(@administrator_menu_nivel0_menu_nivel1.administrator_menu_nivel0_id)
  end

  # GET /administrator/menu_nivel0/menu_nivel1s/new
  def new
    @opcionMenu = Administrator::MenuNivel0.find(params[:format])    

    @administrator_menu_nivel0_menu_nivel1 = Administrator::MenuNivel0::MenuNivel1.new(administrator_menu_nivel0_id: params[:format])
  end

  # GET /administrator/menu_nivel0/menu_nivel1s/1/edit
  def edit
   @administrator_menu_nivel0_menu_nivel1 = Administrator::MenuNivel0::MenuNivel1.find(params[:id])
   @opcionMenu = Administrator::MenuNivel0.find(@administrator_menu_nivel0_menu_nivel1.administrator_menu_nivel0_id)
  end

  # POST /administrator/menu_nivel0/menu_nivel1s
  # POST /administrator/menu_nivel0/menu_nivel1s.json
  def create
    @administrator_menu_nivel0_menu_nivel1 = Administrator::MenuNivel0::MenuNivel1.new(administrator_menu_nivel0_menu_nivel1_params)  
    @administrator_menu_nivel0_menu_nivel1.posicion = Administrator::MenuNivel0::MenuNivel1.where(administrator_menu_nivel0_id: @administrator_menu_nivel0_menu_nivel1.administrator_menu_nivel0_id).count + 1
    
    params[:administrator_menu_nivel0_menu_nivel1][:tipo] = true
 
    respond_to do |format|
      if @administrator_menu_nivel0_menu_nivel1.save
        opcionMenu = Administrator::MenuNivel0.find(@administrator_menu_nivel0_menu_nivel1.administrator_menu_nivel0_id)
        @administrator_menu_nivel0_menu_nivel1.enlace = cambiarEspacioxGiones "#{opcionMenu.enlace}-#{@administrator_menu_nivel0_menu_nivel1.id.to_s}"
        if @administrator_menu_nivel0_menu_nivel1.update(administrator_menu_nivel0_menu_nivel1_params)
          format.html { redirect_to administrator_menu_nivel0_menu_nivel1_path(@administrator_menu_nivel0_menu_nivel1), notice: 'la página fue creada exitosamente' }
          format.json { render :show, status: :created, location: @administrator_menu_nivel0_menu_nivel1 }
        else
          format.html { render :new }
          format.json { render json: @administrator_menu_nivel0_menu_nivel1.errors, status: :unprocessable_entity }
        end 
      else
        format.html { render :new }
        format.json { render json: @administrator_menu_nivel0_menu_nivel1.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administrator/menu_nivel0/menu_nivel1s/1
  # PATCH/PUT /administrator/menu_nivel0/menu_nivel1s/1.json
  def update
    @administrator_menu_nivel0_menu_nivel1 = Administrator::MenuNivel0::MenuNivel1.find(params[:id])
    
    respond_to do |format|
      if params[:administrator_menu_nivel0_menu_nivel1][:titulo_contenido].blank?
        params[:administrator_menu_nivel0_menu_nivel1][:titulo_contenido] = params[:administrator_menu_nivel0_menu_nivel1][:titulo]
      end
      if @administrator_menu_nivel0_menu_nivel1.update(administrator_menu_nivel0_menu_nivel1_params)
        format.html { redirect_to @administrator_menu_nivel0_menu_nivel1, notice: 'la página ha sido modificada exitosamente.' }
        format.json { render :show, status: :ok, location: @administrator_menu_nivel0_menu_nivel1 }
      else
        format.html { render :edit }
        format.json { render json: @administrator_menu_nivel0_menu_nivel1.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrator/menu_nivel0/menu_nivel1s/1
  # DELETE /administrator/menu_nivel0/menu_nivel1s/1.json
  def destroy
    @administrator_menu_nivel0_menu_nivel1.destroy
    respond_to do |format|
      format.html { redirect_to administrator_menu_nivel0_menu_nivel1s_path(@administrator_menu_nivel0_menu_nivel1.administrator_menu_nivel0_id), notice: 'la página ha sido eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator_menu_nivel0_menu_nivel1
      @administrator_menu_nivel0_menu_nivel1 = Administrator::MenuNivel0::MenuNivel1.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_menu_nivel0_menu_nivel1_params

      params.require(:administrator_menu_nivel0_menu_nivel1).permit(
                :titulo, :tipo, :estado, :posicion, :enlace,
                :titulo_contenido, :contenido, :imagen_banner, :administrator_menu_nivel0_id, :opcion)
    end

  def cambiarEspacioxGiones enlace
    enlace.sub(" ", "-") 
  end 
end
