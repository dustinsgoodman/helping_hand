HelpingHand::Application.routes.draw do
  root :controller => :home, :action => :index

  resource :account, :controller => "users"
  resources :users
  resource :users, :controller => "users", :action => "edit"
  resource :users, :controller => "users", :action => "udpate"

  resource :user_sessions
  match "login", :to => 'user_sessions#new', :action => 'login'
  match "logout", :to => 'user_session#destroy', :action => 'logout'
  
  resources :opportunities,
    :controller => :opportunities
end
