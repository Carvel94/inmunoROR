require 'date'

class Datos

def initialize()  
    # Instance variables  
end 


def dia(fecha)
	#puts "FECHA RECIBIDA = #{fecha}"
	if fecha.length > 6  
      dia = fecha.to_date.mday
    else
		exp4=/^\d{1,2}$/ 
    	exp4.match(fecha[0..1]) == nil ? dia = fecha[0] : dia = fecha[0..1]
	end
	dia
end

def mes(fecha)
	mesesHash = {'ene' => '1', 'feb' =>  '2', 'mar' =>  '3', 'abr' =>  '4', 'may' => '5' , 'jun' =>  '6', 'jul' =>  '7', 'ago' =>  '8', 'sep' =>  '9', 'oct' =>  '10', 'nov' =>  '11', 'dic' =>  '12'}

	


	if fecha.length > 6
      mes = fecha.to_date.month
    else
     #puts "FECHA #{fecha}"
	 #puts "MES"
	 #puts fecha[fecha.index(/[\/-]/) + 1, 3]
		
     #puts fecha[-fecha.length + 3..-1]	
	 if mesesHash[fecha[fecha.index(/[\/-]/) + 1, 3]] == nil
	  # puts "FUNCIONA #{is_numeric? fecha[-fecha.length + 3..-1]}"
	   if is_numeric? fecha[-fecha.length + 3..-1]
	   	 mes = fecha[-fecha.length + 3..-1]
	   else	 	
	 	 mes = nil
	   end 
	 else	 
	 	#puts "ENTRO AQUI"
	     mes =  mesesHash[fecha[fecha.index(/[\/-]/) + 1, 3]]
	 end   	
	end
  mes
end

def ano(fecha)
  if fecha.length > 6
  	ano = fecha.to_date.year
  else
  	ano = nil
  end
 ano	
end	

def calcularAnoActual(fechaActual, fechaAnterior)
  anoActual = ano(fechaAnterior)	
  if anoActual == nil 
  	puts anoActual
  end 	
  if mes(fechaActual).to_i < mes(fechaAnterior).to_i
    anoActual = ano(fechaAnterior) + 1
  #else
  #  anoActual = ano(fechaAnterior)   
  end  
  anoActual
end

def is_numeric?(obj) 
	#puts "obj #{obj}"
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
end
end
