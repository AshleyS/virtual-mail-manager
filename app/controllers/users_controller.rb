class UsersController < ApplicationController

  before_filter :auth_only, :_add_crumbs

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

  private

  def _add_crumbs
    add_crumb 'Users', (users_path unless params[:action] == "index")
  end

end
