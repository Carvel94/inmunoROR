class Administrator::Configuration < ActiveRecord::Base
  belongs_to :usuario

  validates :nombre, presence: { message: "Debe colocar un nombre que describa a la imagen" }

  validates :nombre, length: {in: 5..50, 
            too_short: "Debe tener al menos 5 caracteres", 
            too_long: "No debe exceder de 20 carácteres"}

  validates :imagen1, presence: { message: "Debe colocar la ruta de la imagen que desea agregar" }

  #la siguiente linea se coloco en comentario para no usar
  #la función de Amazon S3 ya desarrollada, las fotos se colocan por photobucker
            
  #mount_uploader :imagen1, Imagen1Uploader

  #mount_uploader :imagen2, Imagen2Uploader
  #mount_uploader :imagen3, Imagen3Uploader
  #mount_uploader :imagen4, Imagen4Uploader
  #mount_uploader :imagen5, Imagen5Uploader


def extension_white_list
  %w(jpg jpeg gif png)
end

end
