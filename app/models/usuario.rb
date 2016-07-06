class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :invitable, :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
attr_accessor :saltar_validacion_usuario, :validar_usuario_nuevo

has_many :faqs
has_many :tips
has_many :carrucels
accepts_nested_attributes_for :carrucels
belongs_to :invited_by, :polymorphic => true

#validate :has_been_published, on: :update

validates :historia, :presence => {:message => "Debe colocar el número de historia"},
                       length: {minimum: 1, maximum: 7, :message => "El número de historia debe tener máximo 7 números"},
                       :numericality => {:only_integer => true, :message => "El número de historia solo debe tener números"}, 
                       :uniqueness => {:message => "El número de historia colocado ya se encuentra registrado. El número debe ser único"}, 
                                        unless: :saltar_validacion_usuario

validates :username, presence: true, uniqueness: true,
                     length: {in: 5..20, 
                              too_short: "Debe tener al menos 5 caracteres", 
                              too_long: "debe tener máximo 20 caracteres"},
                      format: {with: /([A-Za-z0-9\-\_\*]+)/, message: "Solo puedes colocar letras, números,guiones y/o *"}

#se sustituye ^ por \A para comienzo de linea y $ por \z para fin de linea
validates :nombre, presence: { message: "Debe colocar el nombre del paciente" },
                     format: {with: /\A[a-zA-Z\ \áéíóú]+\z/, message: "El nombre del paciente solo puede colocar letras y espacios"}

validates :apellido, presence: { message: "Debe colocar el apellido del paciente" },
                       format: {with: /\A[a-zA-Z\ \áéíóú]+\z/, message: "El apellido del paciente Solo puede colocar letras y espacios"}

validates :cedula, allow_blank: true, format: {with: /\A\d+\z/, message: "El número de cédula solo puede contener números"},
                   length: {in: 4..9, 
                            too_short: "Debe tener al menos 4 números", 
                            too_long: "debe tener máximo 10 números"}, if: "!cedula.blank?"

validates :fecha_nacimiento, presence: {message: "Debe colocar la fecha de nacimiento del paciente"},
                                         unless: :saltar_validacion_usuario

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: {message: "Debe colocar su correo electrónico"},
                  format:{:with => VALID_EMAIL_REGEX, message: "El formato del correo electrónico es invalido"}

#validates :email, uniqueness: {message: "El correo ya se encuentra registrado"}
=begin
validates :email_confirmation, presence: {message: "Debe colocar la confirmación del correo principal"}, 
             if: ":validar_usuario_nuevo"
=end
validates :email, confirmation: { message: "El correo principal no coincide con su confirmación"},
            if: ":validar_usuario_nuevo"

validates :email2, allow_blank: true, 
                   format: {:with => VALID_EMAIL_REGEX, 
                            message: "El formato del correo electrónico alternativo es invalido"}
=begin
validates :email2_confirmation, presence: {message: "Debe colocar la confirmación del correo alternativo"}, if: ":validar_usuario_nuevo && !email2.blank?"
=end
validates :email2, confirmation: {message: "El correo alternativo no coincide con su confirmación"}, if: ":validar_usuario_nuevo && !email2.blank?"

validate :presencia_de_algun_telefono, unless: :saltar_validacion_usuario


#SE MODIFICO LO SIGUIENTE
 #validates_presence_of     :password, if: :password_required?
#validates_confirmation_of :password, if: :password_required?

validates :password, presence: {message: "Debe colocar el password nuevo"}, if: :password_required?

validates :password, confirmation: {message: "La confirmación del password no coincide"},     
  if: :password_required?

#validates :current_password, presence: true, if: ":saltar_validacion_usuario"
#validates :password, presence: {message: "Debe colocar el password nuevo"}, if: ":saltar_validacion_usuario"

#validates :password, confirmation: {message: "La confirmación del password no coincide"}, if: ":saltar_validacion_usuario and !password.blank?"

#validates :telefono_habitacion, :validate_telefonos

#validates_format_of :email2, :with => 
#/\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,
#message: "El formato del correo electrónico alternativo es invalido", on: :update


#validates_format_of :email2, :with => Devise::email_regexp, 
#message: "El formato del correo electrónico alternativo es invalido", 
#allow_blank: :true, allow_nil: :true, on: :update


def validar_passwords?
#  validates :password, presence: {message: "Debe colocar su nuevo password"},
#  validates :password, confirmation: {message: "La confirmación del password no coincide"}, if: "!password.blank?"
end

def validar_email?
validates :email, presence: {message: "Debe colocar su correo electrónico"},
                  format:{:with => VALID_EMAIL_REGEX, message: "El formato del correo electrónico es invalido"}
end

def date( *format)
    self[:fecha_nacimiento].strftime(format.first || default)
end

#Método de clase no necesito instanciar la clase para usarlo
def self.buscar_por_campo(campo, search)
  if search 
      Usuario.where("#{campo} ILIKE ?", "%#{search}%").order("apellido")
  else
      scoped
  end
end

def self.aplicar_comparacion_campo(search)
  #se debe refactorizar este código para que se realize en el modelo
  expresion_correo = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/
  expresion_cedula = /^\d*$/
  expresion_nombre = /^([a-zA-Z ñáéíóú]{2,60})$/
  expresion_tratamiento = /^\d{1,5}$/

  if expresion_correo.match(search)
    @pacientes = buscar_por_campo('email',search)
    if @pacientes.count ==0
      "No existen pacientes con esa dirección de correo electrónico, intente de nuevo"
    else 
      @pacientes
    end  
  else
    if expresion_cedula.match(search) || expresion_tratamiento.match(search)
      @pacientes = buscar_por_campo('cedula',search)
      if @pacientes.count ==0
        @pacientes = buscar_por_campo('numero_excel',search)
        if @pacientes.count ==0 
            "No existen pacientes con ese número de tratamiento ó número de cédula, intente de nuevo"
        else 
          @pacientes
        end   
      end
     else
      if expresion_nombre.match(search) 
        @pacientes = buscar_por_campo('nombre',search)
        if @pacientes.count ==0
          @pacientes = buscar_por_campo('apellido',search)
          if @pacientes.empty?
              "No existen pacientes con ese nombre o apellido, intente de nuevo"
          else
              return @pacientes
          end
        else
            return @pacientes 
        end  
      else
          "No existen pacientes con esa información, intente de nuevo con otro valor" 
      end
    end  
  end
end

private 

def has_been_published
    if published_at.future?
      errors.add(:published_at, "is in the future")
    end
end


   def password_required?
        !persisted? || !password.nil? || !password_confirmation.nil?
  end

def presencia_de_algun_telefono
  if [self.telefono_habitacion, self.telefono_trabajo, self.celular1, self.celular2 ].reject(&:blank?).size == 0
    errors.add(:telefono_habitacion, "Debe colocar al menos un teléfono de contacto")
  end 
end




end


