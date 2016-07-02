class WelcomeController < ApplicationController
  def index
  		#@@opcionesMenuPrincipal = MenuNivel0.all

  		#Rails.logger.info @contenidos.to_yaml

  end

   def dynamicroute
    @user = User.find_by_first_name(params[:route])
    #render or redirect, however you wish
  end
end
