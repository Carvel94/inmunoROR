class Tip < ActiveRecord::Base
  belongs_to :usuario

  validates :titulo, presence: { message: "Debe colocar el título del tip de alimentación" }
  validates :contenido, presence: { message: "Debe colocar el contenido del tip de alimentación" }

end
