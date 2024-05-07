require 'sinatra/content_for'
require 'sinatra/flash'

class BaseController < Sinatra::Base
  helpers Sinatra::ContentFor

  set :views, File.expand_path('../../views', __FILE__)

  register Sinatra::Flash

  NON_AUTH_PATHS = [
    '/login',
    '/auth/google_oauth2',
    '/auth/google_oauth2/callback',
    '/auth/cognito-idp',
    '/auth/cognito-idp/callback'
  ].freeze

  before do
    redirect to('/') if request.path_info == '/login' && session[:oauth_id]
    redirect to('/login') if NON_AUTH_PATHS.exclude?(request.path_info) && !session[:oauth_id]
  end
end
