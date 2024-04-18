require_relative 'base_controller'

class AuthController < BaseController
  get '/auth/:provider/callback' do
    auth_hash = request.env['omniauth.auth']

    session[:oauth_id] = auth_hash['uid']
    session[:user_email] = auth_hash['info']['email']

    redirect to('/')
  end

  get '/auth/failure' do
    'Falha na autenticação!'
  end
end
