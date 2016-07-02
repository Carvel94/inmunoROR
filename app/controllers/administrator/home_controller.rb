class Administrator::HomeController < ApplicationController
include CodigosGenerales

#la siguiente linea permite controlar que el usuario este logueado sino redirige a la 
#pagina de inicio de sessión 
before_filter :authenticate_usuario!

before_action :verificar_usuario_autenticado

before_action :verificar_perfil_administrador

 before_action :cargarOpcionesDelPrincipal

layout :colocar_layout

def index
	@contactos = Contacto.where('respuesta' => nil)
end

def cargarOpcionesDelPrincipal
  @opcionesMenu = Administrator::MenuNivel0.all
  @opcionesSubMenu = {}
  @opcionesMenu.each do |opcion|
    enlace = opcion.enlace
    @valores = Administrator::MenuNivel0::MenuNivel1.where(administrator_menu_nivel0_id: opcion.id).order('posicion asc') 
    @opcionesSubMenu.merge!(enlace => @valores )
 end  
end

private 

def verificar_usuario_autenticado
	
	if current_usuario
	  if current_usuario.rol != 1 && current_usuario.rol != 2 && current_usuario.rol != 3	
		redirect_to new_usuario_session_path
	  end 	
	end  	
end

end