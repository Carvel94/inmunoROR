class AddCampoToUsuarios < ActiveRecord::Migration
  def change
  	add_column :usuarios, :frascos, :text
  end
end
