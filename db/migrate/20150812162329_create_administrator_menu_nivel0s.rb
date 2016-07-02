class CreateAdministratorMenuNivel0s < ActiveRecord::Migration
  def change
    create_table :administrator_menu_nivel0s do |t|
      t.string  :titulo
      t.boolean :tipo
      t.boolean :estado
      t.integer :posicion
      t.integer :cantidad
      t.string  :enlace
      t.string  :titulo_contenido
      t.text    :contenido
      t.timestamps null: false
    end
  end
end
