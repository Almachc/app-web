require 'spec_helper'

describe 'GET /auth/:provider/callback', type: :request do
  context 'when authenticating with google' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: 'google_oauth2',
        uid: '123456',
        info: { email: 'user@example.com' }
      })
    end

    it 'logs in the user and redirects to the initial page' do
      get '/auth/google_oauth2/callback'

      user = User.find_by(email: 'user@example.com')
      expect(user).to_not be_nil

      expect(last_request.env['omniauth.auth']).to_not be_nil
      expect(last_request.env['omniauth.auth'].info.email).to eq('user@example.com')
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end

  context 'when authenticating with cognito' do
    let(:authorization_code) { '6ce60c34-c63f-4a47-b992-ef24ecc8208d' }
    let(:access_token) { 'eyJraWQiOiJ3NjZnSHdcL2pJYWh' }

    before do
      OmniAuth.config.test_mode = false

      stub_request(:post, 'https://relabs-pool.auth.us-east-1.amazoncognito.com/oauth2/token')
        .with(
          body: {
            'grant_type' => 'authorization_code',
            'code' => authorization_code,
            'redirect_uri' => 'http://localhost:3000/auth/cognito-idp/callback'
          }
        )
        .to_return(
          status: 200,
          body: {
            access_token: access_token,
            id_token: 'eyJraWQiOiJtWDZ6UTcwYkhqeE56RUQx',
            refresh_token: 'eyJjdHkiOiJKV1QiLCJlbm',
            expires_in: 3600
          }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      stub_request(:get, "https://relabs-pool.auth.us-east-1.amazoncognito.com/oauth2/userInfo")
        .with(
          headers: { 'Authorization' => "Bearer #{access_token}" }
        )
        .to_return(
          status: 200,
          body: {
            sub: '737u8knY-w21q-47f4-y77a-ac4g55h6j7dc',
            email: 'user@example.com'
          }.to_json,
          headers: { 'Content-Type' => 'application/json;charset=UTF-8' }
        )
    end

    it 'logs in the user and redirects to the initial page' do
      state_value = 'ip90y67g4r209d96a5f74c783668b0b587f7d337jyu9024d'
      env 'rack.session', { 'omniauth.state' => state_value }

      get '/auth/cognito-idp/callback', { code: authorization_code, state: state_value }

      expect(last_request.env['omniauth.auth']).to_not be_nil
      expect(last_request.env['omniauth.auth'].info.email).to eq('user@example.com')
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end
end
