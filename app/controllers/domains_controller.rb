class DomainsController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :auth_only, :_add_crumbs
  before_filter :admin_only, :except => [:index, :show]

  def index
    domains = get_authorised_domains

    if params[:search]
      session[:search] = params[:search]
      # Reset page number
      session[:page] = nil
    end

    if params[:page]
      session[:page] = params[:page]
    end

    @domains = domains.search(session[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => session[:page])

    if @domains.all.count == 0 && session[:page]
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
    domains = get_authorised_domains

    @domain = domains.find(params[:id])
    add_crumb @domain.name
  end

  def new
    @domain = Domain.new
    add_crumb 'New'
  end

  def edit
    domains = get_authorised_domains

    @domain = domains.find(params[:id])

    add_crumb @domain.name, domain_path(@domain)
    add_crumb 'Edit'
  end

  def create
    @domain = Domain.new(params[:domain])
    add_crumb 'New'

    if @domain.save
      redirect_to(@domain, :notice => 'Domain was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    domains = get_authorised_domains

    @domain = domains.find(params[:id])
    @domain_name = @domain.name

    add_crumb @domain.name, domain_path(@domain)
    add_crumb 'Edit'

    if @domain.update_attributes(params[:domain])
      redirect_to(@domain, :notice => 'Domain was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    domains = get_authorised_domains

    @domain = domains.find(params[:id])

    if @domain.deletable?
      @domain.destroy
      redirect_to(domains_path, :notice => 'Domain was successfully deleted.')
    else
      flash[:error] = 'URL is not deletable - please delete mailboxes first'
      redirect_to :back
    end
  end

  private

  def get_authorised_domains
    if admin?
      Domain
    else
      @current_user.domains
    end
  end

  def _add_crumbs
    add_crumb 'Domains', (domains_path unless params[:action] == "index")
  end

  def sort_column
    default_sort = "name"
    unless params[:sort].nil?
      session[:sort] = params[:sort]
    end

    if session[:sort].nil?
      session[:sort] = default_sort
    end

    session[:sort] = Domain.column_names.include?(session[:sort]) ? session[:sort] : default_sort
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
