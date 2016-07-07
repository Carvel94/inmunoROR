source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '4.2.6'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'figaro'
gem 'simple_form'  
gem 'devise', github: 'plataformatec/devise'
gem 'devise_invitable', '~> 1.6'
gem 'gibbon'  			#gema para mailchimp
gem 'roo'
gem 'roo-xls'
#la siguiente gema permite manejar varios archivos seeds
gem 'seedbank'
#gem 'mandrill-rails'   #gema para mandrill
gem 'ckeditor'
#gem 'sinatra', github: 'sinatra/sinatra'


gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'font-awesome-sass', '~> 4.0.1'

gem 'will_paginate'
gem 'will_paginate-bootstrap'

#datepicker
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.15.35'

#gem 'bootstrap-datepicker-rails'

gem 'sprockets-rails', :require => 'sprockets/railtie'

#PARA SUBIR IMAGENES A AMAZON S3
# for aws cloud storage
gem 'fog'
# photo resizing
gem "mini_magick"
# file upload solution
#gem 'carrierwave'

#para la generación de menu de navegación dinamico
gem 'simple-navigation'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  #para depuración
  gem 'rails-footnotes', '~> 4.0'

end

group :development do
  gem 'better_errors'
  gem "binding_of_caller"
  gem 'quiet_assets'
  gem 'meta_request'

  #
  #gem 'debugger', '~> 1.6.6'
  gem 'sqlite3'
end

group :production do
  gem 'rails_12factor'
  gem 'thin'
end

group :test do

end
