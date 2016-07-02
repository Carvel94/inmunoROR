class AddCamposToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :cedula, :string
    add_column :usuarios, :numero_excel, :string
    add_column :usuarios, :historia, :string
    add_column :usuarios, :telefono_habitacion, :string
    add_column :usuarios, :telefono_trabajo, :string
    add_column :usuarios, :celular1, :string
    add_column :usuarios, :celular2, :string
    add_column :usuarios, :fecha_nacimiento, :date
    add_column :usuarios, :email2, :string
    add_column :usuarios, :estado, :integer
    add_column :usuarios, :ava, :integer
    add_column :usuarios, :cuc, :integer
    add_column :usuarios, :hong, :integer
    add_column :usuarios, :berm, :integer
    add_column :usuarios, :john, :integer
    add_column :usuarios, :asp, :integer
    add_column :usuarios, :blom, :integer
    add_column :usuarios, :rol, :integer
  end
end
