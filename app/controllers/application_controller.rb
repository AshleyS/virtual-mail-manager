class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :auth_only, :admin_only, :admin?

  before_filter :auth_only, :only => :index

  def index
  end

  private

  def current_user
    #logger.debug "current_user running"

    # Check if @current_user is an instance already
    if @current_user.nil?

      # Check if session has expired
      logger.debug session[:user_id]
      logger.debug session[:remember_me]

      if session[:user_id].present? && session[:remember_me].nil?
        if session[:last_seen].nil? || 1.hour.ago > session[:last_seen]
          # User session expired
          logger.debug "user session expired"
          flash[:error] = "Session has expired"
          redirect_to log_out_path
        else
          logger.debug "user session is fine"
        end
      end

      session[:last_seen] = Time.now

      # Check if :user_id in session and user exists
      if session[:user_id].present? && User.exists?(session[:user_id])
        # Return @current_user
        logger.debug "found user in database"
        @current_user ||= User.find(session[:user_id])
      else
        # Not logged in and/or user doesn't exist, return nil
        logger.debug "not logged in or user not in database"
        @current_user ||= nil
      end

    else
      # @current_user already an instance
      logger.debug "we have a @current_user"
      @current_user
    end
  end

  def auth_only
    if current_user.nil?
      logger.debug "current_user returned nil"
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
    unless admin?
      flash[:error] = "Permission denied"

      begin
        redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to root_path
      end
    end
  end

end
