puts "Borrando registros de nivel 1"
Administrator::MenuNivel0::MenuNivel1.delete_all

puts "Borrando registros de nivel 0"
Administrator::MenuNivel0.delete_all

puts "Creación de las opciones del Menú principal"

Administrator::MenuNivel0.create(titulo: "Qué es <br />la Alergia?",
	 enlace: "alergia", tipo: 0, estado: 1, posicion: 1, cantidad:0)

Administrator::MenuNivel0.create(titulo: "Causas <br />de Alergia",
	 enlace: "tipos", tipo: 0, estado: 1, posicion: 2, cantidad:0)

Administrator::MenuNivel0.create(titulo: "Enfermedades <br />Alergicas",
	 enlace: "enfermedades`", tipo: 0, estado: 1, posicion: 3, cantidad:0)

Administrator::MenuNivel0.create(titulo: "Asma",
	 enlace: "asma", tipo: 0, estado: 1, posicion: 4, cantidad:0)

Administrator::MenuNivel0.create(titulo: "Tratamiento",
	 enlace: "tratamiento", tipo: 0, estado: 1, posicion: 5, cantidad:0)