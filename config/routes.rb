HelpingHand::Application.routes.draw do
  root :to => 'user#show'

  resources :users,
    :controller => :users

  resources :opportunities,
    :controller => :opportunities
end
