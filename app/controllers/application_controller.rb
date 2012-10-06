class ApplicationController < ActionController::Base
 
  helper :all
  helper_method :current_user, :current_user_session, :logged_in?, :admin?, :require_user
 
  def current_user
    if defined?(@current_user)
      @current_user
    else
      @current_user = current_user_session && curent_user_session.record
    end
  end
  
  def logged_in?
    !!current_user
  end
  
  def admin?
    logged_in? && current_user.admin?
  end
  
protected

  def current_user_session
    if defined?(@current_user_session)
      @current_user_session
    else
      @current_user_session = UserSession.find
    end
  end
  
  def require_user
    unless logged_in?
      store_location
      flash[:notice] = "Please log in to continue"
      redirect_to login_path
      return false
    end
  end
  
  def require_no_user
    if logged_in?
      redirect_to account_path
      return false
    end
  end
  
  def log_in_as(user)
    log_out
    @user_session = UserSession.new(user)
    @user_session.save
  end

  def log_out
    unless current_user_session.nil?
      current_user_session.destroy
      flash.delete(:return_to)
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def keep_location
  end
  
   def redirect_to_referrer_or(default, *args)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def redirect_home
    redirect_to root_url
  end
end
