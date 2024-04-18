require_relative 'base_controller'

class HomeController < BaseController
  get '/' do
    erb :index, locals: { user_email: session[:user_email] }
  end

  get '/login' do
    erb :login, locals: { csrf_token: request.env['rack.session']['csrf'] }
  end
end
