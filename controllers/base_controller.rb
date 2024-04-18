require 'sinatra/content_for'

class BaseController < Sinatra::Base
  helpers Sinatra::ContentFor

  set :views, File.expand_path('../../views', __FILE__)

  NON_AUTH_PATHS = [
    '/login',
    '/auth/google_oauth2',
    '/auth/google_oauth2/callback'
  ].freeze

  before do
    redirect to('/') if request.path_info == '/login' && session[:oauth_id]
    redirect to('/login') if !NON_AUTH_PATHS.include?(request.path_info) && !session[:oauth_id]
  end
end
