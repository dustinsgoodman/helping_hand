class UserSession < Authlogic::Session::Base
  disable_magic_states true
  remember_me true
end
