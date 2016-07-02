module CodigosGenerales
extend ActiveSupport::Concern

def colocar_layout
	if current_usuario
		if current_usuario.rol == 1
		  "administrator"	
		else 
		  if current_usuario.rol == 2
		   "tratamiento"
		  else
		  	if current_usuario.rol == 3
		  		"paciente"
		  	end	
		  end
		end  
	end
end

#verifica si el usuario autenticado es del tipo administrador 1
def verificar_perfil_administrador
	if current_usuario.rol ==3
		 redirect_to paciente_path
	end
end

def verificar_perfil_administrador_tratmiento
	if current_usuario.rol ==2
		true
	else
		false
	end
end

def verificar_perfil_administrador_paciente
	if current_usuario.rol ==3
		true
	else
		false
	end
end



def cargarOpcionesDelPrincipal
  puts "OPCIONES 2"
  @opcionesMenu = Administrator::MenuNivel0.all
  @opcionesmenu = Administrator::MenuNivel0.all
  @opcionesmenu = nil 
  @opcionesSubMenu = {}

  @opcionesMenu.each do |opcion|
    enlace = opcion.enlace
    @valores = Administrator::MenuNivel0::MenuNivel1.where(administrator_menu_nivel0_id: opcion.id).order('posicion asc') 
    @opcionesSubMenu.merge!(enlace => @valores )
 end  
end

end
