class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :auth_only, :admin_only, :admin?

  before_filter :auth_only, :only => :index

  def index
  end

  private

  def current_user
    if @current_user.nil?
      if session[:user_id].present? && User.exists?(session[:user_id]) then
        @current_user ||= User.find(session[:user_id])
      else
        nil
      end
    else
      @current_user
    end
  end

  def auth_only
    if current_user.nil?
      session[:user_id] = nil
      redirect_to log_in_path
    end
  end

  def admin?
    if current_user.admin?
      true
    else
      false
    end
  end

  def admin_only
    if admin?
      logger.debug "true"
    else
      logger.debug "false"
      flash[:error] = "Permission denied"
      redirect_to root_path
    end
  end

end
