require 'jwt'
require 'faraday'
require './graphql/operations'

class GraphqlClient
  class << self
    def call(query_or_mutation, variables = {})
      client.post do |req|
        req.body = { query: Graphql::Operations.send(query_or_mutation), variables: variables }
      end
    end

    private

    def client
      Faraday.new(
        url: ENV['GRAPHQL_HOST'],
        headers: {
          'Content-Type' => 'application/json'
        }
      ) do |faraday|
        faraday.request :json
        faraday.response :json
      end
    end
  end
end
