require_relative 'base_controller'
require './clients/graphql_client'

class PoliciesController < BaseController
  get '/policies' do
    response = GraphqlClient.call('get_policies')

    erb :policies, locals: { policies: response.body['data']['policies'] }
  end

  get '/policies/new' do
    erb :new_policy, locals: { csrf_token: request.env['rack.session']['csrf'] }
  end

  get '/policies/:id' do
    response = GraphqlClient.call('get_policy', { id: params[:id] })

    erb :policy_details, locals: { policy: response.body['data']['policy'] }
  end

  post '/policies' do
    input = {
      vehicle: {
        licensePlate: params['vehicle_license_plate'],
        make: params['vehicle_make'],
        model: params['vehicle_model'],
        year: params['vehicle_year']
      },
      insured: {
        name: params['insured_name'],
        documentNumber: params['insured_document'],
      }
    }

    response = GraphqlClient.call('create_policy', input)

    if success?(response)
      flash[:notice] = { type: 'success', message: 'Apólice criada com sucesso' }
      redirect('/policies')
    else
      flash[:notice] = { type: 'error', message: 'Ops, algo deu errado' }
      redirect('/policies/new')
    end
  end

  private

  def success?(response)
    response.success? && !response.body.has_key?('errors')
  end
end
