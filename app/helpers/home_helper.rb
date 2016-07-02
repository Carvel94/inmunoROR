# app/helpers/my_custom_helper.rb
module HomeHelper

  def formatearRespuesta respuesta

   
	if respuesta.length >137
    x = respuesta[0..136].rindex(" ")
    a = respuesta[0..respuesta[0..136].rindex(" ")]
    while 137 - x < 5
      x = a[0..x-1].rindex(" ")
      a =  a[0..x]
    end
        a + "...."    
	else
		respuesta
	end
  end


  def verificarAncla id
  	if !@ancla.empty?
  		@ancla == id.to_s ? "active" : ""
  	else
  	  ""	
  	end	
  end

def formatearContenidoTip contenido
  if contenido.length >380 
        contenido[0..contenido[0..379].rindex(" ")] + "...."    
  else
    contenido
  end
end
end	