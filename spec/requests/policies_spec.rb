require 'spec_helper'

describe 'GET /policies', type: :request do
  before do
    sign_in

    stub_request(:post, ENV['GRAPHQL_HOST'])
      .with(
        headers: { 'Content-Type' => 'application/json' },
        body: {
          query: include('query GetPolicies')
        }
      )
      .to_return(
        status: 200,
        body: {
          data: {
            policies: [
              {
                id: '1',
                effectiveFrom: '2024-04-19',
                effectiveUntil: '2025-04-19',
                insured: {
                  name: 'Homer Simpsons',
                  documentNumber: '1234567891'
                },
                vehicle: {
                  licensePlate: 'abc1234',
                  make: 'chevrolet',
                  model: 'camaro',
                  year: '2024'
                }
              },
              {
                id: '2',
                effectiveFrom: '2024-04-20',
                effectiveUntil: '2025-04-20',
                insured: {
                  name: 'Peter Griffin',
                  documentNumber: '1234567892'
                },
                vehicle: {
                  licensePlate: 'abc1235',
                  make: 'chevrolet',
                  model: 'camaro',
                  year: '2024'
                }
              }
            ]
          }
        }.to_json,
      )
  end

  it 'renders the list of policies' do
    get '/policies'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Homer Simpsons')
    expect(last_response.body).to include('abc1234')
    expect(last_response.body).to include('2024-04-19')
    expect(last_response.body).to include('2025-04-19')
    expect(last_response.body).to include('Peter Griffin')
    expect(last_response.body).to include('abc1235')
    expect(last_response.body).to include('2024-04-20')
    expect(last_response.body).to include('2025-04-20')
  end
end

describe 'GET /policies/:id', type: :request do
  before do
    sign_in

    stub_request(:post, ENV['GRAPHQL_HOST'])
      .with(
        headers: { 'Content-Type' => 'application/json' },
        body: {
          query: include('query GetPolicy'),
          variables: { id: '1' }
        }
      )
      .to_return(
        status: 200,
        body: {
          data: {
            policy: {
              id: '1',
              effectiveFrom: '2024-04-19',
              effectiveUntil: '2025-04-19',
              insured: {
                name: 'Homer Simpsons',
                documentNumber: '1234567891'
              },
              vehicle: {
                licensePlate: 'abc1234',
                make: 'chevrolet',
                model: 'camaro',
                year: '2024'
              }
            }
          }
        }.to_json,
      )
  end

  it 'renders the policy details' do
    get '/policies/1'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('2024-04-19')
    expect(last_response.body).to include('2025-04-19')
    expect(last_response.body).to include('Homer Simpsons')
    expect(last_response.body).to include('1234567891')
    expect(last_response.body).to include('abc1234')
    expect(last_response.body).to include('chevrolet')
    expect(last_response.body).to include('camaro')
    expect(last_response.body).to include('2024')
  end
end
