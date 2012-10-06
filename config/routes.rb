HelpingHand::Application.routes.draw do
  root :to => 'user#index'

  resources :users,
    :controller => :users
  
  resources :opportunities,
    :controller => :opportunities
end
