class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :logged_in?, :admin?
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    @current_user
  end
  
  def admin?
    logged_in? && current_user.admin?
  end
end
