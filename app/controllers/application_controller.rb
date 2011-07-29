class ApplicationController < ActionController::Base
  protect_from_forgery

  add_crumb 'Home', '/'

  helper_method :current_user, :auth_only

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def auth_only
    if current_user.nil?
      redirect_to root_path, :notice => "Unauthorised"
    end
  end

end
