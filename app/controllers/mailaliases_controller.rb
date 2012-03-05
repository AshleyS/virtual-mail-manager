class MailaliasesController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :auth_only, :get_domain, :_add_crumbs
  
  def index
    if params[:search]
      session[:search] = params[:search]
      # Reset page number
      session[:page] = nil
    end

    if params[:page]
      session[:page] = params[:page]
    end

    @mailaliases = @domain.mailaliases.search(session[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => session[:page])

    if @mailaliases.all.count == 0 && session[:page]
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
    @mailalias = @domain.mailaliases.find(params[:id])
  end

  def new
    if @domain.mailaliases.count >= @domain.max_mailaliases
      flash[:error] = "Max number of mailaliases reached"
      redirect_to domain_mailaliases_path(@domain)
    end

    @mailalias = @domain.mailaliases.build
    add_crumb "New"
  end

  def edit
    @mailalias = @domain.mailaliases.find(params[:id])
    add_crumb "Edit"
  end

  def create
    @mailalias = @domain.mailaliases.build(params[:mailalias])
    add_crumb "New"

    if @mailalias.save
      redirect_to(domain_mailalias_path(@domain, @mailalias), :notice => 'Mail alias was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @mailalias = @domain.mailaliases.find(params[:id])
    add_crumb "Edit"

    if @mailalias.update_attributes(params[:mailalias])
      redirect_to(domain_mailalias_path(@domain, @mailalias), :notice => 'Mail alias was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @mailalias = @domain.mailaliases.find(params[:id])
    @mailalias.destroy

    redirect_to(domain_mailaliases_path(@domain), :notice => 'Mail alias was successfully deleted.')
  end

  private

  def get_domain
    if admin?
      domain = Domain
    else
      domain = @current_user.domains
    end
    @domain = domain.find(params[:domain_id])
  end

  def _add_crumbs
    add_crumb 'Domains', domains_path
    add_crumb @domain.name, domain_path(@domain)
    add_crumb 'Aliases', (domain_mailaliases_path(@domain) unless params[:action] == "index")
  end

  def sort_column
    default_sort = "source"
    unless params[:sort].nil?
      session[:sort] = params[:sort]
    end

    if session[:sort].nil?
      session[:sort] = default_sort
    end

    session[:sort] = Mailalias.column_names.include?(session[:sort]) ? session[:sort] : default_sort
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
