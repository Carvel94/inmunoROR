require 'HumanDate'

module ApplicationHelper

def pagination_links(collection, options = {})
   options[:renderer] ||= BootstrapPaginationHelper::LinkRenderer
   options[:class] ||= 'pagination pagination-centered'
   options[:inner_window] ||= 2
   options[:outer_window] ||= 1
   will_paginate(collection, options)
 end

  def paginate(collection, params= {})
    puts collection
    puts params
    
     will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
    

    # will_paginate collection, params.merge(:renderer => BootstrapPaginationHelper::LinkRenderer)


  end

def formatearOpcionMenu opcion
	opcion.sub("<br />", "")  
end

def humanizarFecha(fecha)
#	puts HumanDate.date_distance(Time.now, fecha)
	HumanDate.date_distance(Time.now, fecha)
end

def formatearFecha(fecha)

end

@opcionesmenu = Administrator::MenuNivel0.all
#@opcionesmenu = nil 
@opcionesSubM = {}

def opcionesSubMenu
  puts "SI ENTRO APPLICATIONHHELPER"
  opcionesmenu = Administrator::MenuNivel0.all
  #puts opcionesmenu
  opcionesSubM = {}
  opcionesmenu.each do |opcion|
    enlace = opcion.enlace
    valores = Administrator::MenuNivel0::MenuNivel1.where(administrator_menu_nivel0_id: opcion.id).order('posicion asc') 
    opcionesSubM.merge!(enlace => valores )
  end  
  #puts "METODO #{opcionesSubM}"
  opcionesSubM
end

end
