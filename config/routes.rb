HelpingHand::Application.routes.draw do
  root :to => 'users#index'

  resources :users,
    :controller => :users
  
  resources :opportunities,
    :controller => :opportunities
end
