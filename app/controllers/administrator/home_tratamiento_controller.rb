class Administrator::HomeTratamientoController < ApplicationController
include CodigosGenerales
# before_action :cargarOpcionesDelPrincipal
 
before_action :verificar_perfil_administrador
 
layout :colocar_layout

def index
	if current_usuario
	  if current_usuario.rol = 1 	
		opcionesmenu = Administrator::MenuNivel0.all.order('id asc')
	  end
	  if current_usuario.rol = 2

	  end	
	else
		redirect_to new_usuario_session_path
	end 	
end

private

def colocar_layout
	if current_usuario.rol == 1 
	  "administrator"	
	else 
	  if current_usuario.rol = 2 
	   "tratamiento"
	  end
	end
end
end