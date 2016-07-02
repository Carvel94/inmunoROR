class Paciente
   include ActiveModel::Validations

   attr_accessor :datoBuscar



#   validates_each :first_name, :last_name do |record, attr, value|
 #    record.errors.add attr, 'starts with z.' if value.to_s[0] == ?z
   
 end