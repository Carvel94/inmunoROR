class Faq < ActiveRecord::Base
  belongs_to :usuario
  validates :pregunta, presence: { message: "Debe colocar la pregunta" }
  validates :respuesta, presence: { message: "Debe colocar la respuesta" }
end
