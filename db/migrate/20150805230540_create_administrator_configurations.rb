class CreateAdministratorConfigurations < ActiveRecord::Migration
  def change
    create_table :administrator_configurations do |t|
      t.string :nombre
      t.string :imagen1
      t.string :enlace
      t.string :titulo_mensaje
      t.string :mensaje
      t.boolean :mensaje_visible?
      t.references :usuario, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
