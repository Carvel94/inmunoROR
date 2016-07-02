class Administrator::ContactosController < ApplicationController
# before_action :cargarOpcionesDelPrincipal
before_action :verificar_perfil_administrador
include CodigosGenerales
layout :colocar_layout

def index
	@contactos = Contacto.where('respuesta' => nil).order('created_at desc')
end

def edit
  @contacto = Contacto.find(params[:id])
end

def update
  @contacto = Contacto.find params[:id]
  @contactos = Contacto.all.order('created_at desc')
  respond_to do |format|
    if @contacto.update(contacto_params)
      format.html {redirect_to administrator_contactos_path, notice: 'La respuesta a la consulta fue enviada exitosamente' }
      format.json { render :show, status: :ok, location: @contacto }
    else
    	@erroresContacto = @contacto
      format.html { render :index }
      format.json { render json: @contacto.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
    @contacto = Contacto.find params[:id]
    @contacto.destroy
    respond_to do |format|
      format.html { redirect_to administrator_contactos_path, notice: 'El mensaje fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
end

private
 	def contacto_params
      params.require(:contacto).permit(:nombre, :email, :mensaje, :respuesta, :id)
  end
end
