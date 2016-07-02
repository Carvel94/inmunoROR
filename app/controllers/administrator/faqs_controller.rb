class Administrator::FaqsController < ApplicationController
include CodigosGenerales

#la siguiente linea permite controlar que el usuario este logueado sino redirige a la 
#pagina de inicio de sessión 
 before_filter :authenticate_usuario!
 
 before_action :cargarOpcionesDelPrincipal

before_action :verificar_perfil_administrador

#before_action :redirect_to_root, :if => :signed_in?

layout "administrator"

  def index
  	 @faqs = Faq.all.order('created_at desc')
     if @faqs.empty?
       flash.now[:warning] = "Aún no se han creado preguntas y respuestas" 
     end
  end

  def show
    @faq = Faq.find(params[:id])
  end

  def new
    @faq = Faq.new
  end

  def edit
    @faq = Faq.find( params[:id] )
  end

  def create
    @faq = Faq.new(faq_params)
    @faq.usuario_id = current_usuario.id
    respond_to do |format|
      if @faq.save
        format.html { redirect_to administrator_faq_path(@faq), notice: 'La pregunta fue creada exitosamente' }
        format.json { render :show, status: :created, location: @faq }
      else
        format.html { render :new }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @faq = Faq.find params[:id]
    @faq.usuario_id = current_usuario.id
    respond_to do |format|
      if @faq.update(faq_params)
        format.html {redirect_to administrator_faq_path(@faq), notice: 'La pregunta fue modificada exitosamente' }
        format.json { render :show, status: :ok, location: @faq }
      else
        format.html { render :edit }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @faq = Faq.find params[:id]
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to administrator_faqs_path(@faq), notice: 'La pregunta fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_faq
      @faq = Faq.find(params[:id])
    end

 	def faq_params
      params.require(:faq).permit(:pregunta, :respuesta)
  end
end


