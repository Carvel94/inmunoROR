class CreateMensajes < ActiveRecord::Migration
  def change
    create_table :mensajes do |t|
      t.string :nombre
      t.text :mensaje
      t.text :respuesta
      t.references :usuario

      t.timestamps null: false
    end
  end
end
