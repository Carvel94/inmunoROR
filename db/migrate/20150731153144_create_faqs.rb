class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :pregunta
      t.text :respuesta
      t.references :usuario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
