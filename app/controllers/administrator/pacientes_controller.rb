#class Administrator::PacientesController < Devise::RegistrationsController

class Administrator::PacientesController < ApplicationController
  before_action :all_pacientes, only: [:index, :create, :update, :destroy]
  before_action :set_pacientes, only: [:edit, :update, :destroy]
  respond_to :html, :js  

prepend_before_filter :require_no_authentication, only: [ :cancel]
#prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]
skip_before_filter :require_no_authentication, :only => [:create, :update]

before_action :verificar_perfil_administrador



include CodigosGenerales
layout :colocar_layout

def buscar
   @paciente = Paciente.new
   @pacientes = Usuario.new
   @@mensaje = ""

  if params[:paciente]       
      if (params[:paciente][:datoBuscar].present?)       
          @pacientes = Usuario.aplicar_comparacion_campo(params[:paciente][:datoBuscar]) 
          if @pacientes.class.to_s != "String"
              @pacientes = @pacientes.paginate(:page => params[:page], :per_page => 10) 
          else
            flash.now[:alert] = @pacientes
            @pacientes = nil
            
          end
      else
        flash.now[:alert] = "No ha colocado la información"
        @pacientes = nil
      end 
   end
   
end


def index
  @pacientes = Usuario.where(rol: 3)..last(2)
end 

def new
  puts "HOLA"
	super
end

def edit
  puts "EPALE EDIT"
  puts params[:format]

  if !params[:format].blank?
    @paciente = Usuario.find( params[:format])
    build_resource({})
    self.resource = @paciente
    render editPaciente 
  else
    render :edit
  end
end 

def editPaciente
  puts "EPALE"
    @paciente = Usuario.find( params[:id])
    build_resource({})
    self.resource = @paciente
    render :editPaciente 
end

def update
  if current_usuario.rol ==1 or current_usuario.rol ==2 or current_usuario.rol ==3
        self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
      resource.saltar_validacion_usuario = true

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      puts resource.methods

      
      if resource_updated
        if is_flashing_format?
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key
        end
        sign_in resource_name, resource, bypass: true
        respond_with resource, location: after_update_path_for(resource)
      else
        clean_up_passwords resource
        respond_with resource
      end 
   else
      params[:usuario][:username] = "alerasin"+params[:usuario][:historia]
      params[:usuario][:password] = params[:usuario][:username]
      params[:usuario][:password_confirmation] = params[:usuario][:username]
      params[:usuario][:rol] = 3
      params[:usuario][:estado] = 1
      if account_update_params[:password].blank?
          account_update_params.delete(:password)
          account_update_params.delete(:password_confirmation)
      end

    @paciente = Usuario.find(params[:usuario][:id])
    self.resource = @paciente
      respond_to do |format|
          if self.resource.update(account_update_params)
            format.html { redirect_to usuario_registration_path(self.resource.id), notice: 'Los datos del paciente fueron modificados correctamente' }
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }
            format.json { render json: @paciente.errors, status: :unprocessable_entity }
          end
        end
    end
end 

def create
  params[:usuario][:username] = "alerasin"+params[:usuario][:historia]
  params[:usuario][:password] = params[:usuario][:username]
  params[:usuario][:password_confirmation] = params[:usuario][:username]
  params[:usuario][:rol] = 3
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


    def all_pacientes
      @pacientes= Task.all
    end

    def set_pacientes
      @paciente = Usuario.find(params[:id])
    end


def usuario_params
    params.require(:usuario).permit(
           :numero_excel,
           :email, 
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
           :fecha_pruebas
      )
  end

  # https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  def needs_password?(usuario, params)
    params[:password].present?
  end

def sign_up_params
	allow = [:email, 
           :numero_excel, 
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

def account_update_params
params.require(:usuario).permit(
          :numero_excel,
  				 :email, 
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
           :fecha_pruebas)
end

#el siguiente método permite customizar el redirect despues de actualizar
#los datos personales
  def after_update_path_for(resource)
    adminHome_path(resource)
  end



end