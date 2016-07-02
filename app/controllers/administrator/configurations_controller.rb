class Administrator::ConfigurationsController < ApplicationController
include CodigosGenerales

#la siguiente linea permite controlar que el usuario este logueado sino redirige a la 
#pagina de inicio de sessión 
before_filter :authenticate_usuario!

before_action :verificar_perfil_administrador

before_action :cargarOpcionesDelPrincipal
  
  before_action :set_administrator_configuration, only: [:show, :edit, :update, :destroy]
  before_action :calcular_cantidad_imagen_carrucel, only: [:new]
  layout "administrator"

  # GET /administrator/configurations
  # GET /administrator/configurations.json
  def index
    @administrator_configurations = Administrator::Configuration.all
    if @administrator_configurations.empty?
       flash.now[:warning] = "Aún no se han agregado imagenes al carrucel" 
     end
  end

  # GET /administrator/configurations/1
  # GET /administrator/configurations/1.json
  def show
    @cantidad = Administrator::Configuration.all.length
  end

  # GET /administrator/configurations/new
  def new
    @cantidad = Administrator::Configuration.all.length
    @administrator_configuration = Administrator::Configuration.new
  end

  # GET /administrator/configurations/1/edit
  def edit
    @carrucel = Administrator::Configuration.find( params[:id] )
  end

  # POST /administrator/configurations
  # POST /administrator/configurations.json
  def create
    @administrator_configuration = Administrator::Configuration.new(administrator_configuration_params)
    @administrator_configuration.usuario_id = current_usuario.id
      puts "en el create"
      @cantidad = Administrator::Configuration.all.length

    respond_to do |format|
      if @administrator_configuration.save
        puts "CREATE save"
        format.html { redirect_to @administrator_configuration, 
                      notice: 'La imagen fue agregada exitosamente.' }
        format.json { render :show, status: :created, location: @administrator_configuration }
      else
        @administrator_configuration.errors.each do |attr,msg| 
          puts msg if @administrator_configuration.errors[attr].first == msg 
        end                      
        format.html { render :new }
        format.json { render json: @administrator_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administrator/configurations/1
  # PATCH/PUT /administrator/configurations/1.json
  def update
    @carrucel = Administrator::Configuration.find( params[:id] )
    #puts Administrator::Configuration.find( params[:id] )
    #puts administrator_configuration_params
    respond_to do |format|
      if @administrator_configuration.update(administrator_configuration_params)
        format.html { redirect_to @administrator_configuration,
                      notice: 'La imagen fue actualizada exitosamente' }
        format.json { render :show, status: :ok, location: @administrator_configuration }
      else
        format.html { render :edit }
        format.json { render json: @administrator_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrator/configurations/1
  # DELETE /administrator/configurations/1.json
  def destroy
    @administrator_configuration.destroy
    respond_to do |format|
      format.html { redirect_to administrator_configurations_url, notice: 'La imagen del carrucel fue eliminada exitosamente' }
      format.json { head :no_content }
    end
  end

  private

    def calcular_cantidad_imagen_carrucel
      puts "calcular_cantidad_imagen_carrucel"
 @imagenes = Administrator::Configuration.all.length
    end  

    # Use callbacks to share common setup or constraints between actions.
    def set_administrator_configuration
      @administrator_configuration = Administrator::Configuration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_configuration_params
      params.require(:administrator_configuration).permit(:nombre, :enlace, :titulo_mensaje, :mensaje, :mensaje_visible, :imagen1, :imagen2, :imagen3, :imagen4, :imagen5, :usuario_id)
    end
end
