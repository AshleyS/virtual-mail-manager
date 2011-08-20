class UsersController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :auth_only, :_add_crumbs

  def index
    @users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
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
      redirect_to users_path, :notice => "Account was successfully created."
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
    if User.all.size == 1 then
      flash[:error] = "At least one user must exist"
      redirect_to :back
    elsif params[:id].to_i == current_user.id then
      flash[:error] = "Can't delete yourself"
      redirect_to :back
    else
      @user = User.find(params[:id])
      @user.destroy

      redirect_to(users_path, :notice => 'User was successfully deleted.')
    end
  end

  private

  def _add_crumbs
    add_crumb 'Users', (users_path unless params[:action] == "index")
  end

  def sort_column
    Domain.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
