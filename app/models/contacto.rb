class Contacto < ActiveRecord::Base

validates :nombre, presence: { message: "Debe colocar su nombre completo" },
          format: {with: /\A[a-zA-Z\ \áéíóú]+\z/, 
		  message: "Su nombre solo puede contener letras y espacios"},
		  on: :create

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validate :presencia_de_algun_telefono, on: :create

validates :email, allow_blank: true, 
				  format:{:with => VALID_EMAIL_REGEX, 
                  message: "El formato del correo electrónico es invalido"},
				   on: :create

validates :mensaje, presence: {
	message: "Debe colocar el motivo de la cita médica"},
	on: :create

validates :respuesta, presence: {
	message: "Debe colocar la respuesta que desea enviar al usuario que realizo esta consulta"},
	 on: :update

after_update :enviar_notificacion

def enviar_notificacion
	ContactoMailer.respuestaContacto_email(self).deliver_now
end

def presencia_de_algun_telefono
  if [self.telefono_local, self.telefono_celular].reject(&:blank?).size == 0
    errors.add(:telefono_habitacion, "Debe colocar al menos un teléfono de contacto")
  end 
end

end
