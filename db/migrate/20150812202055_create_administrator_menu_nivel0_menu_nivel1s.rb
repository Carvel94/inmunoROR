class CreateAdministratorMenuNivel0MenuNivel1s < ActiveRecord::Migration
  def change
    create_table :administrator_menu_nivel0_menu_nivel1s do |t|
	t.string  :titulo
    t.integer :tipo
    t.boolean :estado
    t.integer :posicion
    t.string  :enlace
    t.string  :titulo_contenido
    t.text    :contenido   
    t.string  :imagen_banner   
    t.timestamps null: false
    t.references :administrator_menu_nivel0,  foreign_key: true
    end
  end
end
