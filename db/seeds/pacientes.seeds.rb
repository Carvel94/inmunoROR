require 'date'

require("#{Rails.root}/db/seeds/frascos.seeds.rb")

#se eliminan todos los datos que pueden estar en la tabla usuarios

puts "¿DESEA BORRAR LOS REGISTROS DE PACIENTES DE LA TABLA USUARIOS Y(Yes) N (No)?"  
STDOUT.flush
respuesta = "N"
respuesta = STDIN.gets.chomp
if respuesta == "Y"
  respuesta2 = "N"
  puts "REALMENTE ESTA USTED SEGURO QUE DESEA ELIMINAR LOS PACIENTES Y(Yes) N (No)?"
  respuesta2 = STDIN.gets.chomp
  if respuesta2 == "Y"
    puts "BORRANDO REGISTROS ANTERIORES"
    Usuario.delete_all ["id > 3"]
  end  
end

#guardo los datos del excel en un arreglo llamado celdas
ex = Roo::Excel.new("#{Rails.root}/db/seeds/Pacientes-de-Inmunoterapia4.xls")
ex.default_sheet = ex.sheets.first
posC=0

puts "MIGRACION DATOS DE USUARIOS DEL ARCHIVO DE EXCEL A LA TABLA USUARIOS"

fechaActual = DateTime.now
pos=''

frascos = Frascos.new()

for fila in (4 .. ex.last_row)
       #for fila in (4 .. 77)
       puts "FILA = #{fila} ANALIZANDO USUARIO =#{ex.cell(fila,1).to_s.sub('.0','')}" 


       if ex.cell(fila,2) != nil && ex.cell(fila,3) != nil
        usuario = {
              #el siguiente campo es el número de paciente en tratamiento
              #que correponde con la hoja de excel
              :numero_excel => ex.cell(fila,1).to_s.sub(".0",""),
              :apellido => ex.cell(fila,2).strip.split[0],
              :nombre => ex.cell(fila,3).strip.split[0],
              :historia => ex.cell(fila,4).to_s.sub(".0",""),
              :fecha_nacimiento => ex.cell(fila,6).to_s.sub(".0",""),
              :cedula => ex.cell(fila,7).to_s.sub(".0",""),
              :telefono_habitacion => "02125555555",
              :telefono_trabajo => "02127777777",
              :celular1 => nil,
              :celular2 => nil,
              :email => ex.cell(fila,2).strip.split[0].downcase+ex.cell(fila,3).strip.split[0].downcase+ "@gmail.com",
              :email2 => ex.cell(fila,2).strip.split[0].downcase+ex.cell(fila,3).strip.split[0].downcase+ "@gmail.com",
              #se esta colocando como username y password:
              #historia-numero
              #por ejemplo para el usuario 
              :username => "inmuno" + ex.cell(fila,1).to_s.sub(".0",""),
              :password => "inmuno" + ex.cell(fila,1).to_s.sub(".0","")
            }

#            puts usuario
if usuario[:telefono_habitacion].strip.length ==0
  usuario[:telefono_habitacion] = nil
end      
if usuario[:telefono_trabajo].strip.length ==0
  usuario[:telefono_trabajo] = nil
end 

if !usuario[:email].nil? 
  if usuario[:email].strip.length == 0
   usuario[:email] = usuario[:username]+"@cambiarcorreo.com"   
 end
else
  usuario[:email] = usuario[:username]+"@cambiarcorreo.com"  
end      

expresion = /(0416|0412|0414|0424)-\d{7}/
m = expresion.match(usuario[:telefono1])

if expresion.match(usuario[:telefono_habitacion]) 
  usuario[:celular1] = usuario[:telefono_habitacion]
  usuario[:telefono_habitacion] = nil
  if expresion.match(usuario[:telefono_trabajo])                
    usuario[:celular2] = usuario[:telefono_trabajo]
    usuario[:telefono_trabajo] = nil 
  end
else
  if expresion.match(usuario[:telefono_trabajo])                
    usuario[:celular1] = usuario[:telefono_trabajo]
    usuario[:telefono_trabajo] = nil 
  end
end

infoFrasco = frascos.analizandoFila(ex, fila) 

u = Usuario.new(numero_excel: usuario[:numero_excel].to_i,
 nombre: usuario[:nombre], 
 apellido: usuario[:apellido],
 historia: usuario[:historia],
 telefono_habitacion: usuario[:telefono_habitacion],
 telefono_trabajo: usuario[:telefono_trabajo],
 cedula:usuario[:cedula],
 celular1: usuario[:celular1],
 celular2: usuario[:celular2],
 email: usuario[:email],
 email2: usuario[:email2],
 username: usuario[:username],
 password: usuario[:password],
 rol: 3,
 frascos: infoFrasco 
 )

if respuesta == "Y" && respuesta2 =="Y"
  puts "salvando"
  u.save(validate: false)
end


end      
end