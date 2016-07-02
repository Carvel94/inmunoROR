# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Borrar registros de Usuarios"

puts "Borrando registros de FAQ"
Faq.destroy_all

puts "Borrando registros de TIP"
Tip.destroy_all

puts "Borrando registros de configuraciones"
Administrator::Configuration.destroy_all

puts "Borrando usuarios"
Usuario.destroy_all

puts "Reset sequencias ID de todas las tablas:"
ActiveRecord::Base.connection.tables.each do |table|
  result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1") rescue ( puts "Warning: not procesing table #{table}. Id is missing?" ; next )
  ai_val = result.any? ? result.first['id'].to_i + 1 : 1
  puts "Resetting auto increment ID for #{table} to #{ai_val}"
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
end

puts "Crear el usuario: root"

u = Usuario.new(
  username: "root",
  nombre: "Usuario root",
  apellido: "",
  email: "root@gmail.com",
  password: '12345678',
  rol: 0,
  cedula: 1111111,
  fecha_nacimiento: "01/01/2000",
  telefono_habitacion: "04145555555"

)
u.save!(validate: false)

puts "Crear usuarios: doctores"
puts "Usuario: Armando"
u = Usuario.new(
  username: "doctorcms",
  nombre: "doctorcms",
  apellido: "doctorcms",
  email: "doctorcms@gmail.com",
  password: '12345678',
  rol: 1,
  cedula: 2222222,
  fecha_nacimiento: "01/01/1900",
  telefono_habitacion: "02125555555"
)

u.save!(validate: false)

puts "Usuario: susana"
u = Usuario.new(
  username: "doctortrata",
  nombre: "doctortrata",
  apellido: "doctortrata",
  email: "doctortrata@gmail.com",
  password: '12345678',
  rol: 2,
  cedula: 3333333,
  fecha_nacimiento: "01/01/1900",
  telefono_habitacion: "02125555555"
)
u.save!(validate: false)

