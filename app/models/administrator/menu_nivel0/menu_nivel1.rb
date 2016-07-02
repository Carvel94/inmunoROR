class Administrator::MenuNivel0::MenuNivel1 < ActiveRecord::Base

#belongs_to :administrator_menu_nivel0, :class_name => "::MenuNivel1"

belongs_to :administrator_menu_nivel0, :class_name => '::Administrator::MenuNivel0'

#self.table_name = 'administrator_menu_nivel0_menu_nivel1s'

#se comento la siguiente linea por que el cliente no quiere 
#cargar imagenes en amazon s3, sino en photobucket
#mount_uploader :imagen_banner, Imagen1Uploader

validates :titulo, presence: { message: "Debe colocar el texto que se mostrará en el menú de opciones" }

validates :titulo, uniqueness: { message: "Ya existe una página con el mismo título en el menú de opciones" }

validates :titulo, length: { maximum: 24, message: "El número máximo de caracteres es de 24"} 

validates :contenido, presence: { message: "Debe colocar el contenido que se mostrará la página" }


#t.string :titulo
#      t.integer :tipo
#      t.integer :estado
#      t.integer :posicion
#      t.string :enlace
#      t.string :titulo_contenido
#      t.text   :contenido      


def extension_white_list
  %w(jpg jpeg gif png)
end
end


