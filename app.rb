require 'debug'
require "awesome_print"

class App < Sinatra::Base

    # Funktion för att prata med databasen
    # Exempel på användning: db.execute('SELECT * FROM fruits')
    def db
      return @db if @db

      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
    end

    # Routen /todos
  
    get '/todos' do  
      @todos = db.execute('SELECT * FROM todos ORDER BY name')
      p @todos
      erb(:"index")
    end


  post '/todos/:id/delete' do | id |

      db.execute('DELETE FROM todos WHERE id= ' +id)
    redirect ('/todos')
    end
end
