class UsersController < ApplicationController

  before_filter :auth_only, :_add_crumbs

  def index
    @users = User.scoped
  end

  def show
    @user = User.find(params[:id])
    add_crumb @user.username
  end

  def new
    @user = User.new
    add_crumb 'New'
  end

  def edit
    @user = User.find(params[:id])
    add_crumb @user.username, user_path(@user)
    add_crumb 'Edit'
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => "Account was successfully created."
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    add_crumb @user.username, user_path(@user)
    add_crumb 'Edit'

    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => 'Account was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to(users_path, :notice => 'User was successfully deleted.')
  end

  private

  def _add_crumbs
    add_crumb 'Users', (users_path unless params[:action] == "index")
  end

end
