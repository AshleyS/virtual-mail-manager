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
      redirect_to root_path
    else
      flash.now[:error] = "Invalid email/password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
