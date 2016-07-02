class Paciente::PacientesController < ApplicationController
before_action :verificar_usuario_autenticado

include CodigosGenerales

#la siguiente linea permite controlar que el usuario este logueado sino redirige a la 
#pagina de inicio de sessión 
before_filter :authenticate_usuario!

layout :colocar_layout


def index
	@contactos = Contacto.where('respuesta' => nil)
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