require 'sinatra/content_for'

class BaseController < Sinatra::Base
  helpers Sinatra::ContentFor

  set :views, File.expand_path('../../views', __FILE__)
end
