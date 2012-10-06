class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :logged_in?, :admin?, :require_user
  
  def current_user
    unless @current_user_loaded
      @current_user = (current_user_session && current_user_session.user) || nil
      @current_user_loaded = true
    end
    @current_user
  end
  
  def logged_in?
    !!current_user
  end
  
  def admin?
    logged_in? && current_user.admin?
  end
  
protected

  def current_user_session
    unless @current_user_session_loaded
      @current_user_session = UserSession.find
      @current_user_session_loaded = true
    end
    @current_user_session
  end
  
  def require_user
    unless logged_in?
      store_location
      flash[:notice] = "Please log in to continue"
      redirect_to login_path
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
  
    def require_no_user
    if logged_in?
      redirect_to account_path
      return false
    end
  end

  def store_location
    if request.format.html?
      #logger.debug "Storing return location: #{request.request_uri}"
      #session[:return_to] = request.request_uri
    end
  end

  def keep_location
  end
  
   def redirect_to_referrer_or(default, *args)
    if session[:return_to] && (session[:return_to] != request.request_uri)
      dest = session[:return_to]
      session.delete(:return_to)
      logger.debug "Using saved location for redirect: #{dest}"
      redirect_to dest, *args
    else
      logger.debug "Using default location for redirect: #{default}"
      redirect_to default, *args
    end
  end
  
  def redirect_home
    redirect_to root_url
  end
end
