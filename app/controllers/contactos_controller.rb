class ContactosController < ApplicationController
 before_action :cargarMenuPrincipal

  def index

  end

  def show
    @contacto = Contacto.find(params[:id])
  end

  def new
  	puts "Contacto new"
    @contacto = Contacto.new
  end

#  def edit
#    @contacto = Contacto.find( params[:id] )
#  end

  def create
    @contacto = Contacto.new(contacto_params)
    respond_to do |format|
      if @contacto.save
        format.html { redirect_to contacto_path(@contacto), 
        	notice: 'Su mensaje fue enviado exitosamente, en un lapso de 48 horas
        	será contactado para concretar la fecha de la cita médica. Si lo desea también puede llamarnos a los telefonos: 0212 991.46.20 ó 0212 999.01.53'}
        format.json { render :show, status: :created, location: @contacto }
      else
        format.html { render :new }
        format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

#  def update
#    @faq = Faq.find params[:id]
#    @faq.usuario_id = current_usuario.id
#    respond_to do |format|
#      if @faq.update(faq_params)
#        format.html {redirect_to administrator_faq_path(@faq), notice: 'La pregunta fue modificada exitosamente' }
#        format.json { render :show, status: :ok, location: @faq }
#      else
#        format.html { render :edit }
#        format.json { render json: @faq.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  def destroy
    @faq = Faq.find params[:id]
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to administrator_faqs_path(@faq), notice: 'La pregunta fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

def cargarMenuPrincipal
  @opcionesMenu = Administrator::MenuNivel0.all

  #OPCIONESUBMENU = {}

  @opcionesmenu = Administrator::MenuNivel0.all
  @opcionesmenu = nil 
  @opcionesSubMenu = {}

  @opcionesMenu.each do |opcion|
    enlace = opcion.enlace
    @valores = Administrator::MenuNivel0::MenuNivel1.where(administrator_menu_nivel0_id: opcion.id).order('posicion asc') 
    @opcionesSubMenu.merge!(enlace => @valores )
 end  
end

  private
    def set_contacto
      @contacto = Contacto.find(params[:id])
    end

 	def contacto_params
      params.require(:contacto).permit(:nombre, :email, :mensaje, :respuesta, 
        :telefono_local, :telefono_celular)
  end
end