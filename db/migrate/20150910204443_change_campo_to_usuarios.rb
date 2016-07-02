class ChangeCampoToUsuarios < ActiveRecord::Migration
  def change
  	change_table :usuarios do |t|
      t.change :email, :string, null:false, unique: false, default: ""  
    end
  end
end