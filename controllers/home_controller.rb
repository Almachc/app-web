require_relative 'base_controller'

class HomeController < BaseController
  get '/' do
    erb :index
  end
end
