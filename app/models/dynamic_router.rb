class DynamicRouter
def self.load
    Alerasin::Application.routes.draw do
      Nivel0.all.each do |pg|
        puts "Routing #{pg.enlace}"
        get "/#{pg.enlace}", :to => "pages_dynamic#show",  defaults: { id: pg.id }
      end
    end
  end

  def self.reload
    Alerasin::Application.routes_reloader.reload!
  end
end