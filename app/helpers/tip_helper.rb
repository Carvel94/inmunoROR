# app/helpers/my_custom_helper.rb
module TipHelper

  def tipoMensaje tipo
    tipo == "notice" ? "success" : "warning"
  end
end	
