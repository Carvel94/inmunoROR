# Devise:: le estamos indicando que herede de devise.
#no se va a escribir el código del controlador de devise sino que vamos a modificar #solamente lo que el padre (devise) haría.
#luego es nesario que el router se modifique para que utilice el nuevo controlador

class RegistrationsController < Devise::RegistrationsController
prepend_before_filter :require_no_authentication, only: [ :cancel]
prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]
skip_before_filter :require_no_authentication, :only => [:create, :update]
before_action :cargarOpcionesDelPrincipal

include CodigosGenerales
layout :colocar_layout

def index
  @pacientes = Usuario.where(rol: 3).order("apellido").paginate(:page => params[:page], :per_page => 30)
end 

def new
  @numero_paciente = Usuario.last.numero_excel.to_i + 1

	super

#  @paciente.numero_excel = Usuario.last.numero_excel
end

def edit
  #if !params[:format].blank?
  #  @paciente = Usuario.find( params[:format])
  #  build_resource({})
  #  self.resource = @paciente
  #  render editPaciente 
  #else
    render :edit
  #end
end 

def editPaciente
  @paciente = Usuario.find(params[:id])
  build_resource({})
  self.resource = @paciente
  #render :editPaciente 
end


def update
  @paciente = Usuario.find(params[:usuario][:id])
  if @paciente != current_usuario
    @numero_paciente = Usuario.last.numero_excel.to_i + 1
    #estado = 1 PENDIENTE
    params[:usuario][:estado] = 1
    if params[:usuario][:ava].blank? and 
      params[:usuario][:cuc].blank? and 
      params[:usuario][:hong].blank? and 
      params[:usuario][:berm].blank? and
      params[:usuario][:john].blank? and
      params[:usuario][:aso].blank? and
      params[:usuario][:blom].blank?  
      params[:usuario][:fecha_pruebas] = nil     
    end
    
    if account_update_params[:password].blank?
      account_update_params.delete(:password)
      account_update_params.delete(:password_confirmation)
    end
    
    @paciente = Usuario.find(params[:usuario][:id])
    self.resource = @paciente
    self.resource.saltar_validacion_usuario = false

    #respond_to do |format|
    #
    #def update_resource(resource, params)
    if params[:usuario][:password].blank? && params[:usuario][:password_confirmation].blank?
      if self.resource.update_without_password(account_update_params)

     # if self.resource.update(account_update_params)
        flash.now[:notice] = "Los datos del paciente fueron modificados correctamente"
        redirect_to usuario_registration_path(@paciente.id)
        #format.json { head :no_content }
      else
        #format.html { render :editPaciente }
        render :editPaciente
        #format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
    #end
  end  
end 

def create
  @numero_paciente = Usuario.last.numero_excel.to_i + 1
  params[:usuario][:username] = "alerasin"+params[:usuario][:numero_excel]
  params[:usuario][:password] = params[:usuario][:username]
  params[:usuario][:password_confirmation] = params[:usuario][:username]
  params[:usuario][:rol] = 3
  #ESTADO = 1, PENDIENTE
  params[:usuario][:estado] = 1

  if params[:usuario][:ava].blank? and 
     params[:usuario][:cuc].blank? and 
     params[:usuario][:hong].blank? and 
     params[:usuario][:berm].blank? and
     params[:usuario][:john].blank? and
     params[:usuario][:aso].blank? and
     params[:usuario][:blom].blank?  
     params[:usuario][:fecha_pruebas] = nil     
  end

  build_resource(sign_up_params)
  #respond_to do |format|
  @usuario.saltar_validacion_usuario = false
  @usuario.validar_usuario_nuevo = true
    if resource.save(state: :cambiando_password)
      @paciente = Usuario.where(historia: params[:usuario][:historia]).first
      redirect_to usuario_registration_path(@paciente.id)
    #  format.html { redirect_to usuario_registration_path(self.resource.id)}
    #  format.json { head :no_content }
    else
      clean_up_passwords resource
      respond_with resource
    #end
  end  
end

def show
   @paciente = Usuario.find(params[:format])
end

def adminHome
    render 'devise/registrations/show' 
end


private

# https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  def needs_password?(usuario, params)
    params[:password].present?
  end

def sign_up_params
	allow = [:email, 
           :username, 
           :nombre, 
           :apellido, 
           :password, 
           :password_confirmation,
           :email,
           :email_confirmation,
           :cedula,
           :numero_excel,
           :historia,
           :estado,
           :telefono_habitacion, 
           :telefono_trabajo,
           :celular1, 
           :celular2, 
           :email2, 
           :email2_confirmation,
           :fecha_nacimiento, 
           :ava,
           :cuc,
           :hong,
           :berm,
           :john,
           :asp,
           :blom,
           :rol,
           :fecha_pruebas ]

	params.require(resource_name).permit(allow)
end

def update_resource(resource, params)
  resource.update_without_password(params)
end

def update_resource(resource, params)
    resource.update_without_password(params)
  end


def account_update_params
  puts params[:usuario][:nombre]

params.require(:usuario).permit(
  				 :email, 
           :username, 
           :nombre, 
           :apellido, 
#           :password, 
#           :password_confirmation,
           :email,
           :email_confirmation,
           :cedula,
           :numero_excel,
           :historia,
           :estado,
           :telefono_habitacion, 
           :telefono_trabajo,
           :celular1, 
           :celular2, 
           :email2, 
           :email2_confirmation,
           :fecha_nacimiento, 
           :ava,
           :cuc,
           :hong,
           :berm,
           :john,
           :asp,
           :blom,
           :rol,
           :fecha_pruebas)
end

#el siguiente método permite customizar el redirect despues de actualizar
#los datos personales
  def after_update_path_for(resource)
    adminHome_path(resource)
  end



end