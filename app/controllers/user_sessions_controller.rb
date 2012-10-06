class UserSessionsController < ApplicationController
  skip_before_filter :store_location
  before_filter :keep_location
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:destroy]
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.remember_me = true
    @user_session.save do |res|
      respond_to do |format|
        format.html do
          if res
            flash[:notice] = "Login Successful"
            redirect_to_referrer_or root_url
          else
            flash[:error] = "Unable to login, please check your email and password and try again."
            render :action => :new
          end
        end
        format.json do
          if res
            render :json => {:success => true, :reload => true}
          else
            render :json => {
              :success => false,
              :error => "Unable to login, please check your email and password and try again."
            }
          end
        end
      end
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful"
    redirect_to root_url
  end
  
  private
  
  def fail_login(message)
    flash[:error] = message
    redirect_to login_url
  end
end