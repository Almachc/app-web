require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Cognito < OmniAuth::Strategies::OAuth2
      option :name, 'cognito-idp'

      option :client_options, {
        site: 'https://relabs-pool.auth.us-east-1.amazoncognito.com',
        authorize_url: '/oauth2/authorize',
        token_url: '/oauth2/token',
        redirect_uri: 'http://localhost:3000/auth/cognito-idp/callback'
      }

      uid { raw_info['sub'] }

      info do
        { email: raw_info['email'] }
      end

      def raw_info
        @raw_info ||= access_token.get('/oauth2/userInfo').parsed
      end

      def build_access_token
        authorization_code = request.params['code']
        client.auth_code.get_token(authorization_code)
      end
    end
  end
end
