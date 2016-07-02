Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log


#JOSELITO SE COLOCO ESTO PARA ER LOS GLIPHICONS
# Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = true


  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.action_mailer.perform_deliveries = true # Set it to false to disable the email in dev mode
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default charset: "utf-8"

  #en producción colocar la dirección del dominio
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.assets.debug = true

  config.action_mailer.smtp_settings = { 
    :address => "smtp.mandrillapp.com", 
    :port => 587, 
    :user_name => ENV["MANDRILL_USERNAME"], 
    :password => ENV["MANDRILL_API_KEY"] 
}

Time::DATE_FORMATS[:custom_date] = "%d/%m/%Y"
Time::DATE_FORMATS[:custom_datetime] = "%d/%m/%Y | %H:%M"



end


=begin

 */module Footnotes
  module Notes
    class CurrentUsuarioNote < AbstractNote
      # This method always receives a controller
      #
      def initialize(controller)
        @current_Usuario = controller.instance_variable_get("@current_Usuario")
      end

      # Returns the title that represents this note.
      #
      def title
        "Current Usuario: #{@current_Usuario.name}"
      end

      # This Note is only valid if we actually found an Usuario
      # If it's not valid, it won't be displayed
      #
      def valid?
        @current_Usuario
      end

      # The fieldset content
      #
      def content
        escape(@current_Usuario.inspect)
      end
    end
  end
end

=end