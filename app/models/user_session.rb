class UserSession < Authlogic::Session::Base
  
  find_by_login_method :find_by_login_or_email
  
  disable_magic_states true
  remember_me true
  
  login_field :login
  password_field :password
end