require_relative 'base_controller'
require './clients/graphql_client'

class PoliciesController < BaseController
  get '/policies' do
    response = GraphqlClient.call('get_policies')

    erb :policies, locals: { policies: response.body['data']['policies'] }
  end

  get '/policies/:id' do
    response = GraphqlClient.call('get_policy', { id: params[:id] })

    erb :policy_details, locals: { policy: response.body['data']['policy'] }
  end
end
