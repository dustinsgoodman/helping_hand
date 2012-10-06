HelpingHand::Application.routes.draw do
  root :controller => :home, :action => :index

  resources :users,
    :controller => :users

  resource :user_session, :only => [:new, :create, :destroy]
  with_options :controller => "user_sessions" do |sess|
    sess.get '/login', :action => 'new'
    sess.post '/logout', :action => 'destroy',
      :conditions => {:method => :delete}
  end
  
  resources :opportunities,
    :controller => :opportunities
end
