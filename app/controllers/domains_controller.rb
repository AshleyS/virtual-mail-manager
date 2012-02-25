class DomainsController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :auth_only, :_add_crumbs

  def index
    @domains = @current_user.domains.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def show
    @domain = @current_user.domains.find(params[:id])
    add_crumb @domain.name
  end

  def new
    @domain = Domain.new
    add_crumb 'New'
  end

  def edit
    @domain = @current_user.domains.find(params[:id])
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
    @domain = @current_user.domains.find(params[:id])
    add_crumb @domain.name, domain_path(@domain)
    add_crumb 'Edit'

    if @domain.update_attributes(params[:domain])
      redirect_to(@domain, :notice => 'Domain was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @domain = @current_user.domains.find(params[:id])

    if @domain.deletable?
      @domain.destroy
      redirect_to(domains_path, :notice => 'Domain was successfully deleted.')
    else
      flash[:error] = 'URL is not deletable - please delete mailboxes first'
      redirect_to :back
    end
  end

  private

  def _add_crumbs
    add_crumb 'Domains', (domains_path unless params[:action] == "index")
  end

  def sort_column
    Domain.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
