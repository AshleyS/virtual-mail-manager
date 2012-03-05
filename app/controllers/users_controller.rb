class UsersController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :_add_crumbs
  before_filter :admin_only, :except => [:show, :edit, :update]

  def index
    if params[:search]
      session[:search] = params[:search]
      # Reset page number
      session[:page] = nil
    end

    if params[:page]
      session[:page] = params[:page]
    end

    @users = User.search(session[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])

    if @users.all.count == 0 && session[:page]
      logger.debug "no results on this page, going back a page"
      new_page = session[:page].to_i - 1
      if new_page == 0
        session[:page] = nil
      else
        session[:page] = new_page
      end

      render :action => index
    end
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
    @user = User.new
    @user.accessible = :all if admin?
    @user.attributes = params[:user]

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

    @user.accessible = :all if admin?

    if @current_user.id == @user.id && @current_user.admin? && params[:user][:admin] == "0"
      flash.now[:error] = "You can't revoke your own admin status"
      render :action => "edit"
      return
    end

    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => 'Account was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    if User.all.size == 1
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

    add_crumb 'Users', (users_path unless params[:action] == "index" || !admin?)
  end

  def sort_column
    default_sort = "username"
    unless params[:sort].nil?
      session[:sort] = params[:sort]
    end

    if session[:sort].nil?
      session[:sort] = default_sort
    end

    session[:sort] = User.column_names.include?(session[:sort]) ? session[:sort] : default_sort
  end

  def sort_direction
    default_direction = "asc"
    unless params[:direction].nil?
      session[:direction] = %w[asc desc].include?(params[:direction]) ? params[:direction] : default_direction
    end

    if session[:direction].nil?
      session[:direction] = default_direction
    end

    session[:direction]
  end

end
