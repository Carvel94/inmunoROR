class Administrator::MenuNivel0 < ActiveRecord::Base
has_many :administrator_menu_nivel0_menu_nivel1s, :class_name => '::Administrator::MenuNivel0::MenuNivel1'
#self.table_name = 'administrator_menu_nivel0s'
end


