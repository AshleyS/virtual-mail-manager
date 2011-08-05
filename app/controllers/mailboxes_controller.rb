class MailboxesController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :auth_only, :get_domain, :_add_crumbs

  def index
    @mailboxes = @domain.mailboxes.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def show
    @mailbox = @domain.mailboxes.find(params[:id])
  end

  def new
    @mailbox = @domain.mailboxes.build
    add_crumb "New"
  end

  def edit
    @mailbox = @domain.mailboxes.find(params[:id])
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
    @domain = Domain.find(params[:domain_id])
  end

  def _add_crumbs
    add_crumb 'Domains', domains_path
    add_crumb @domain.name, domain_path(@domain)
    add_crumb 'Mailboxes', (domain_mailboxes_path(@domain) unless params[:action] == "index")
  end

  def sort_column
    Mailbox.column_names.include?(params[:sort]) ? params[:sort] : "email"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
