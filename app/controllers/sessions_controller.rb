class SessionsController < Devise::SessionsController
before_action :cargarMenuPrincipal

layout "application"
 #after_filter :after_sign_in_path_for(resources)

def new
  super
end

def create
  #super do |resource|
    #  BackgroundWorker.trigger(resource)
    #end
  super
end

def destroy
  super
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

#protected
#    def after_sign_in_path_for(resource)
#      admin_administrators_cms_path_for(resource)
#    end

#protected    
#  def user_layout    
#    puts current_usuario.admin?
#    if current_usuario.admin?    
#      "admin"     
#    else    
#      "application"     
#    end    
#  end   

end