class CreateAdministratorTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :titulo
      t.text :contenido
      t.string :tags
      t.references :usuario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
