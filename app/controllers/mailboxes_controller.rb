class MailboxesController < ApplicationController

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

    @mailboxes = @domain.mailboxes.search(session[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 4, :page => session[:page])

    if @mailboxes.all.count == 0 && session[:page]
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
    @mailbox = @domain.mailboxes.find(params[:id])
  end

  def new
    if @domain.mailboxes.count >= @domain.max_mailboxes
      flash[:error] = "Max number of mailboxes reached"
      redirect_to domain_mailboxes_path(@domain)
    end

    @mailbox = @domain.mailboxes.build
    add_crumb "New"
  end

  def edit
    @mailbox = @domain.mailboxes.find(params[:id])
    @mailbox_name = @mailbox.email
    add_crumb "Edit"
  end

  def create
    @mailbox = @domain.mailboxes.build(params[:mailbox])
    add_crumb "New"

    if @mailbox.save
      redirect_to(domain_mailbox_path(@domain, @mailbox), :notice => 'Mailbox was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @mailbox = @domain.mailboxes.find(params[:id])
    @mailbox_name = @mailbox.email

    add_crumb "Edit"

    if @mailbox.update_attributes(params[:mailbox])
      redirect_to(domain_mailbox_path(@domain), :notice => 'Mailbox was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @mailbox = @domain.mailboxes.find(params[:id])
    @mailbox.destroy

    redirect_to(domain_mailboxes_path(@domain), :notice => 'Mailbox was successfully deleted.')
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
    add_crumb 'Mailboxes', (domain_mailboxes_path(@domain) unless params[:action] == "index")
  end

  def sort_column
    default_sort = "email"
    unless params[:sort].nil?
      session[:sort] = Mailbox.column_names.include?(params[:sort]) ? params[:sort] : default_sort
    end

    if session[:sort].nil?
      session[:sort] = default_sort
    end

    session[:sort]
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
