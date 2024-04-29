require 'spec_helper'

describe 'GET /login', type: :request do
  let(:response) { get '/login' }

  it 'renders the login page' do
    expect(response.status).to eq(200)
    expect(response.body).to include('Login')
  end
end

describe 'GET /', type: :request do
  let(:response) { get '/' }

  before { sign_in }

  it 'renders the initial page' do
    expect(response.status).to eq(200)
    expect(response.body).to include('Página inicial')
    expect(response.body).to include('user@example.com')
  end
end
