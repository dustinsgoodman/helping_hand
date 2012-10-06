HelpingHand::Application.routes.draw do
  root :controller => :home, :action => :index

  resources :users,
    :controller => :users

  resources :opportunities,
    :controller => :opportunities
end
