class UsuariosController < ApplicationController
layout "administrator"

 before_filter :authenticate_usuario!

  def edit
    puts "AQUI2"
    @usuario = current_usuario
  end

  def update_password
    @usuario = Usuario.find(current_usuario.id)
    respond_to do |format|
    if @usuario.update_with_password(usuario_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @usuario, :bypass => true
      format.html { redirect_to root_path, notice: 'Su contraseña fue modificada exitosamente' }
    else
      format.html { render "edit"}
    end
  end
  end


  private

  def usuario_params
    # NOTE: Using `strong_parameters` gem
    params.require(:usuario).permit(:current_password, :password, :password_confirmation)
  end
end