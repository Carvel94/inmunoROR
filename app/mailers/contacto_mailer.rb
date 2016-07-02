class ContactoMailer < ActionMailer::Base
  default from: "no-reply@alerasin.com"
  default to: " tecnodetalles@gmail.com"

def mandrill_client
	mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
end

def respuestaContacto_email(contacto)
    @contacto = contacto
    puts "respuestaContacto_email"
    puts @contacto.email
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    mail(to: @contacto.email, subject: 'ALERASIN - Respuesta a su consulta')
end

def contacto(contacto)
	template_name = "contacto"  #este contacto es el valor que está en el 
							  #campo slug cuando se crea el template
	template_content = []
	message = {
		to:[{email: contacto.email, name: contacto.nombre}],
		subject: "Respuesta nueva: #{contacto.nombre}", 
		merge_vars: [
			{rcpt:"tecnodetalles@gmail.com",
			vars:[{name: "CONTACTO_NOMBRE", content: contacto.nombre}]
			}
		]  #estas son las variables que necesita en template
	}						  
	mandrill_client.messages.send_template template_name, template_content, message 
end
end
