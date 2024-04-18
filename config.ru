require 'rack/handler/puma'
require_relative './app'

Rackup::Handler::Puma.run(
  App,
  Port: 3000,
  Host: '0.0.0.0'
)
