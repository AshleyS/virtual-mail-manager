class SessionsController < ApplicationController
  def index
    redirect_to new_session_path
  end
  
  def new
    if current_user
      redirect_to domains_path
    end
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      session[:last_seen] = Time.now

      if params[:remember_me]
        session[:remember_me] = true
      end

      redirect_to root_path
    else
      flash.now[:error] = "Invalid username/password"
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
