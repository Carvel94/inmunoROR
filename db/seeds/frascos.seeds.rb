require 'date'
require("#{Rails.root}/db/seeds/datos.rb")

class Frascos

def initialize()  
    # Instance variables  
end 

def analizandoFila(ex, fila)

m = Datos.new() 

expresion1 = /SUSPENDIO|SUSPENDIDO/
expresion2 = /NUNCA/
expresion3 = /SUSPENDIO|SUSPENDIDO|NUNCA|NO RETIRO/

  log = true
  numeroFrasco = 1
  infoFrasco = ""
  columna = 12
  fechaAnterior = ""

  while (columna <=100)
   # puts "COLUMNA = #{columna}"
    #cada fila se guarda en una cadena con el siguente formato:
    #$frascoN#fecha1#fecha2$frascoN+1#fecha1#fecha2$.....
    #infoFrasco tendra en un ciclo toda la información del frasco

    dato1 = ex.cell(fila,columna).to_s.sub(".0","")
    dato2 = ex.cell(fila,columna+1).to_s.sub(".0","")
  
  if dato1.to_s.strip == '' && dato2.to_s.strip ==''
    infoFrasco = infoFrasco+ "$" + numeroFrasco.to_s + '##' 
  else  
            infoFrasco = infoFrasco+ "$" + numeroFrasco.to_s + '#'
            if expresion1.match(dato1)
              infoFrasco = infoFrasco + "SUSPENDIO"
              columna = 101
            else
              if expresion3.match(dato1)
                infoFrasco = infoFrasco + "NO RETIRO"
                columna = 101
              else
                if dato1.length >= 5 && dato1.length <=6
                  anoActual = m.calcularAnoActual(dato1, fechaAnterior)  
                  
                     #if m.mes(dato1).to_i < m.mes(fechaAnterior).to_i
                     #  anoActual = m.ano(fechaAnterior) + 1
                     #else
                     #  anoActual = m.ano(fechaAnterior)   
                     #end 

                     dato1 = "#{anoActual}-#{m.mes(dato1)}-#{m.dia(dato1)}"  
                end  
                       
                begin 
                  Date.parse dato1 
                  fechaAnterior = dato1 
                  rescue 
                    dato1 = "" 
                  end
                  infoFrasco = infoFrasco + dato1 + "#"
                  #if dato1 != ""
                  #  if dato1.to_date.instance_of? Date
                  #    fechaAnterior = dato1 
                  #  end
                  #end
              end
            end            
           
              if expresion1.match(dato2)
                infoFrasco = infoFrasco + "SUSPENDIO"
                columna = 101
              else
                if expresion3.match(dato2)
                  infoFrasco = infoFrasco + "NO RETIRO"
                  columna = 101
                else
                  if dato2.length >=5 && dato2.length <= 6
                    if dato2.strip != ""  
                    anoActual = m.calcularAnoActual(dato2, dato1)                 
               #       if m.mes(dato2).to_i < m.mes(dato1).to_i
               #         anoActual = m.ano(dato1) + 1
               #       else
               #         anoActual = m.ano(dato1)   
               #       end  
                      dato2 = "#{anoActual}-#{m.mes(dato2)}-#{m.dia(dato2)}"  
                    end
                  end  

                  begin 
                  Date.parse dato2 
                    fechaAnterior = dato2 
                  rescue 
                    dato2 = "" 
                  end                  
                  infoFrasco = infoFrasco + dato2.to_s
                  
                  #if dato2 != ""
                  #  if dato2.to_date.instance_of? Date
                  #    fechaAnterior = dato2 
                  #  end
                  #end    
                  
            end
          end 
    end    
    columna = columna + 2
    numeroFrasco= numeroFrasco + 1
  end  
 
  #limpiar la cadena infoFrasco de frascos vacios al final
  expresion4 = /[$]\d+[##]/
  log = true

  # el siguiente if verifica si en infoFrasco hay una cadena igual a:
  # $<numero>##
  if  !infoFrasco.rindex(/[$]\d+##/).nil?
    numero = 0
    
    #el siguiente if verifica si la cadena $<numero>## no está de primero
    # para poder eliminar todos las cadenas $<numero## vacias que estan despues
    # del ultimo valor valido
    if infoFrasco.rindex(/[$]\d+##/) > infoFrasco.length - infoFrasco.rindex(/[$]\d+##/)
    
        eliminar =  infoFrasco[-infoFrasco.length + infoFrasco.rindex(/[$]\d+##/)..-1]

        eliminar.length == 5 ? numero = eliminar[1,2].to_i : numero = eliminar[1,1].to_i 

        # el siguente ciclo elimina todas las cadenas que tengan $<numero>## pero comenzando desde el final de la cadena
        
        while log
          if !infoFrasco.rindex(/[$]#{numero}##/).nil?  
            infoFrasco = infoFrasco.sub(infoFrasco[-infoFrasco.length + infoFrasco.rindex(/[$]#{numero}##/)..-1],"")
              numero = numero -1  
          else
            log = false
          end
        end  
     end
end 

  if infoFrasco.strip == ""
    infoFrasco = infoFrasco.strip
  end  

infoFrasco

end #fin del método: analizandoFila

end #fin de la clase
 