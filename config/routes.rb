HelpingHand::Application.routes.draw do
  root :to => 'user#index'

  match 'user' => 'user#index', as: 'user'
end
