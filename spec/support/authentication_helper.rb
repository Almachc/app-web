module AuthenticationHelper
  def sign_in
    env 'rack.session', { oauth_id: '123456', user_email: 'user@example.com' }
  end
end
