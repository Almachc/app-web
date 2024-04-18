require 'sinatra'
require 'faraday'
require 'dotenv/load'
require './routes'

class App < Sinatra::Base
  use Routes
end
