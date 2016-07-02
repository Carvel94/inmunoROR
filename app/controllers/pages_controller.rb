class PagesController < ApplicationController
# before_action :cargarMenuPrincipal

# helper_method :opcionesMenu
# helper_method :opcionesSubMenu

 def home
  if current_usuario
    if current_usuario.rol == 1
      opcionesmenu = Administrator::MenuNivel0.all.order('id asc')
      redirect_to admin_path
    end
    if current_usuario.rol == 2
      redirect_to admin_path
    end 
    if current_usuario.rol == 3
      puts "paciente 3"
      redirect_to paciente_path
    end 

  else
  	# Works with nested subfolders
  	template = File.join(params[:controller], "home")
  	@@opcionesMenuPrincipal = Administrator::MenuNivel0.all
    @faqs = Faq.order('created_at desc').limit(4)
    @tips = Tip.order('created_at desc').limit(4)
    @carrucels = Administrator::Configuration.all

    render "home"
#    rescue ActionView::MissingTemplate => e	
#  	if e.message =~ %r{Missing template #{template}}
#  		raise ActionController::RoutingError, 'Not Found'
#  	else
#  		raise e
#  	end
  end
end

def faq
 @faqs = Faq.order('created_at desc') 
end

def tip
 @tips = Tip.order('created_at desc') 
end

#def opcionesMenuPrincipal
#    @@opcionesMenuPrincipal = Administrator::MenuNivel0.all
#end

#def opcionPrincipal
#  render params[:opcion]
#end

def alergia
  #Que es la alergia
end

def causas
  #Causas y alergia
end

def enfermedades
  #Enfermedades y alergia
end

def asma
  #Asma
end

def embarazo
  #Asma y embarazo
end 

def gripe
  #gripe y alergia
end

def tratamiento
  #Tratamiento y alergia
end


def contenido
  @pagina = Administrator::MenuNivel0::MenuNivel1.find(params[:format])
  #la siguiente línea funciona por que en los modelos se coloco :class_name
  @opcionMenu0 = @pagina.administrator_menu_nivel0
  @enlaces = Administrator::MenuNivel0::MenuNivel1.where(administrator_menu_nivel0_id: @pagina.administrator_menu_nivel0_id ).order('id asc') 
  #@enlaces = Administrator::MenuNivel0.all.order('posicion asc') 
end

def contact
 render "contacto"
end

#def opcionesMenu
# Administrator::MenuNivel0.all
#end

def cargarMenuPrincipal
  @opcionesMenu = Administrator::MenuNivel0.all
  @opcionesSubMenu = {}

  @opcionesMenu.each do |opcion|
    enlace = opcion.enlace
    @valores = Administrator::MenuNivel0::MenuNivel1.where(administrator_menu_nivel0_id: opcion.id).order('posicion asc') 
    @opcionesSubMenu.merge!(enlace => @valores )
 end  
end

#def opcionesSubMenu
#  opcionesmenu = Administrator::MenuNivel0.all
#  opcionesSubM = {}
#  opcionesmenu.each do |opcion|
#    enlace = opcion.enlace
#    valores = Administrator::MenuNivel0::MenuNivel1.where(administrator_menu_nivel0_id: opcion.id).order('posicion asc') 
#    opcionesSubM.merge!(enlace => valores )
#  end  
#  opcionesSubM
#end

end
