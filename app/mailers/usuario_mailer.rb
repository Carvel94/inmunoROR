class UsuarioMailer < BaseMandrillMailer
  include Devise::Mailers::Helpers

  def welcome(usuario_id)
    usuario = Usuario.find(usuario_id)
    subject = "Welcome to our awesome app!"
    merge_vars = {
      "FIRST_NAME" => usuario.first_name,
      "USER_URL" => usuario_url(usuario),
    }
    body = mandrill_template("welcome", merge_vars)

    send_mail(user.email, subject, body)
  end


 default :from => ENV["MANDRILL_USERNAME"]

 def reset_password_instructions(record, opts={})
  mail(:to => record, :subject => "Reset Password Instructions")
 end

end