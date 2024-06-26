require 'sinatra'
require 'faraday'
require 'dotenv/load'
require 'omniauth'
require 'omniauth-google-oauth2'
require 'sinatra/activerecord'
require './routes'
require './omniauth/strategies/cognito'

class App < Sinatra::Base
  FOUR_HOURS = 14400

  configure do
    set :sessions, true
    set :database_file, './config/database.yml'
  end

  use Rack::Session::Cookie, secret: ENV['SESSION_SECRET'], httponly: true, expire_after: FOUR_HOURS

  use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], scope: 'email'
    provider :cognito, ENV['COGNITO_CLIENT_ID'], ENV['COGNITO_CLIENT_SECRET'], scope: 'email openid'
  end

  use Routes
end
