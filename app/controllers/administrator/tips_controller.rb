class Administrator::TipsController < ApplicationController
  include CodigosGenerales

#la siguiente linea permite controlar que el usuario este logueado sino redirige a la 
#pagina de inicio de sessión 
before_filter :authenticate_usuario!

before_action :cargarOpcionesDelPrincipal

before_action :verificar_perfil_administrador

before_action :set_tip, only: [:show, :edit, :update, :destroy] 

  layout "administrator"


  def index
     @tips = Tip.all.order('created_at desc')
     if @tips.empty?
       flash.now[:warning] = "Aún no se han creado tips de alimentación" 
     end
  end

  def show
    @tip = Tip.find(params[:id])
  end

  def new
    @tip = Tip.new
  end

  def edit
    @tip = Tip.find(params[:id] )
  end

  def create
    @tip = Tip.new(tip_params)
    @tip.usuario_id = current_usuario.id
    respond_to do |format|
      if @tip.save
        format.html { redirect_to administrator_tip_path(@tip), notice: 'El tip de alimentación fue creado exitosamente' }
        format.json { render :show, status: :created, location: @tip }
      else
        format.html { render :new }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @tip = Tip.find params[:id]

    respond_to do |format|
      if @tip.update(tip_params)
        format.html {redirect_to administrator_tip_path(@tip), notice: 'tip de alimentación fue modificado exitosamente' }
        format.json { render :show, status: :ok, location: @tip }
      else
        format.html { render :edit }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tip = Tip.find params[:id]
    @tip.destroy
    respond_to do |format|
      format.html { redirect_to administrator_tips_path(@tip), notice: 'El tip de alimentación fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_tip
      @tip = Tip.find(params[:id])
    end

  def tip_params
      params.require(:tip).permit(:titulo, :contenido, :tags, :usuario_id)
  end
end