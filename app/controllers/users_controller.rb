class UsersController < ApplicationController

  before_filter :auth_only

  def index
    @users = User.scoped
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => "Account created"
    else
      render "new"
    end
  end

end
