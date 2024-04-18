require_relative 'controllers/auth_controller'
require_relative 'controllers/home_controller'
require_relative 'controllers/policies_controller'

class Routes < Sinatra::Base
  use AuthController
  use HomeController
  use PoliciesController
end
