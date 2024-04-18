require 'sinatra'

class App < Sinatra::Base
  get '/' do
    'Página inicial'
  end
end
