require 'jwt'
require 'faraday'
require './graphql/operations'

class GraphqlClient
  ONE_MINUTE = 60

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
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{token}"
        }
      ) do |faraday|
        faraday.request :json
        faraday.response :json
      end
    end

    def token
      @token ||= JWT.encode({ exp: Time.now.to_i + ONE_MINUTE }, ENV['JWT_SECRET'], 'HS256')
    end
  end
end
