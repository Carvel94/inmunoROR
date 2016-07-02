module PacienteHelper

	def existe_campo(campo)
		if campo.nil?
			""
		else
			campo
		end
	end	

	def existe_fecha(fecha)
		if fecha.nil?
			""
		else
			#puts "AA#{fecha}AA"
			#puts fecha.strftime("%d/%m/%Y")
			 fecha.strftime("%d/%m/%Y")	
			 fecha
		end
	end

	def numero_tratamiento(paciente)
		if paciente.blank? 
			"alerasin"+paciente.numero_excel
		else	
			paciente.username
		end	
	end	 
end
