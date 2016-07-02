class CreatePagos < ActiveRecord::Migration
  def change
    create_table :pagos do |t|
      t.date :fecha_pago
      t.integer :tipo_pago
      t.string :numero
      t.string :banco
      t.decimal :monto
      t.references :usuarios

      t.timestamps null: false
    end
  end
end
