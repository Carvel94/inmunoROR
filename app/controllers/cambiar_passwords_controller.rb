class CambiarPasswordsController < ApplicationController
  include CodigosGenerales
#  before_filter :authenticate_usuario!
  before_action :cargarOpcionesDelPrincipal
 # prepend_before_filter :require_no_authentication

  #append_before_filter :assert_reset_token_passed, :only => :edit

  layout :colocar_layout

  def edit
    #@usuario = current_usuario
    @usuario = current_usuario
  end

def update_password
  #User.new state: :editing_profile
  #@usuario = Usuario.new(state: :cambiando_password)
  @usuario = Usuario.find(current_usuario.id)
  @usuario.saltar_validacion_usuario = true

  if @usuario.update_with_password(usuario_params)

    # Sign in the user by passing validation in case their password changed
    sign_in @usuario, :bypass => true
    current_usuario = @usuario
    flash.now[:success] = "Su contraseña fue modificada exitosamente"
    render "edit"
  else
    render "edit"
  end
 end


private
 def resource_name
    :usuario
  end

  def resource
    @resource ||= Usuario.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:usuario]
  end


  def usuario_params
    params.require(:usuario).permit(:current_password, :password, :password_confirmation)
 #   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(::current_password, :password, :password_confirmation)}
  end

end	