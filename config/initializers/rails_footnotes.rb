=begin
  
rescue Exception => e
  
enddefined?(Footnotes) && Footnotes.setup do |f|
  # Whether or not to enable footnotes
  f.enabled = Rails.env.development?

  Footnotes::Filter.notes += [:current_usuario]

 puts Footnotes::Filter.notes

  f.font_size = '16px'

  # You can also use a lambda / proc to conditionally toggle footnotes
  # Example :
  # f.enabled = -> { User.current.admin? }
  # Beware of thread-safety though, Footnotes.enabled is NOT thread safe
  # and should not be modified anywhere else.

  # Only toggle some notes :
   f.notes = [:current_usuario, :session, :cookies, :params, :filters, :routes, :env, :queries, :log]

   puts f.notes
  # Change the prefix :
  # f.prefix = 'mvim://open?url=file://%s&line=%d&column=%d'

  f.prefix = 'subl://open?url=file://%s&line=%d&column=%d'



  # Disable style :
  # f.no_style = true

  # Lock notes to top right :
  # f.lock_top_right = true

  # Change font size :
  # f.font_size = '11px'

  # Allow to open multiple notes :
   f.multiple_notes = true
end


=end