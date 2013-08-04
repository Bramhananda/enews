module Admin
class SessionsController < ::Devise::SessionsController
  layout 'login'
  # the rest is inherited, so it should work
end
end