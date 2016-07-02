class AddCamposToContactos < ActiveRecord::Migration
  def change
    add_column :contactos, :telefono_local, :string
    add_column :contactos, :telefono_celular, :string
  end
end
