require_relative 'base_controller'

class PoliciesController < BaseController
  get '/policies' do
    query = <<-GRAPHQL
      query GetPolicies {
        policies {
          id
          effectiveFrom
          effectiveUntil
          insured {
            name
            documentNumber
          }
          vehicle {
            licensePlate
            make
            model
            year
          }
        }
      }
    GRAPHQL

    client = Faraday.new(url: ENV['GRAPHQL_HOST'], headers: { 'Content-Type' => 'application/json' })

    response = client.post do |req|
      req.body = { query: query }.to_json
    end

    erb :policies, locals: { policies: JSON.parse(response.body)['data']['policies'] }
  end

  get '/policies/:id' do
    query = <<-GRAPHQL
      query GetPolicy($id: ID!) {
        policy(id: $id) {
          effectiveFrom
          effectiveUntil
          insured {
            name
            documentNumber
          }
          vehicle {
            licensePlate
            make
            model
            year
          }
        }
      }
    GRAPHQL

    client = Faraday.new(url: ENV['GRAPHQL_HOST'], headers: { 'Content-Type' => 'application/json' })

    policy = client.post do |req|
      req.body = { query: query, variables: { id: params[:id] } }.to_json
    end

    erb :policy_details, locals: { policy: JSON.parse(policy.body)['data']['policy'] }
  end
end
