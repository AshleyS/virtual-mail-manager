class MailboxesController < ApplicationController

  before_filter :get_domain, :_add_crumbs

  def index
    @mailboxes = @domain.mailboxes.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mailboxes }
    end
  end

  def show
    @mailbox = @domain.mailboxes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mailbox }
    end
  end

  def new
    @mailbox = @domain.mailboxes.build
    add_crumb "New"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mailbox }
    end
  end

  def edit
    @mailbox = @domain.mailboxes.find(params[:id])
    add_crumb "Edit"
  end

  def create
    @mailbox = @domain.mailboxes.build(params[:mailbox])
    add_crumb "New"

    respond_to do |format|
      if @mailbox.save
        format.html { redirect_to(domain_mailbox_path(@domain, @mailbox), :notice => 'Mailbox was successfully created.') }
        format.xml  { render :xml => @mailbox, :status => :created, :location => @mailbox }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mailbox.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @mailbox = @domain.mailboxes.find(params[:id])
    add_crumb "Edit"

    respond_to do |format|
      if @mailbox.update_attributes(params[:mailbox])
        format.html { redirect_to(domain_mailbox_path(@domain), :notice => 'Mailbox was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mailbox.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @mailbox = @domain.mailboxes.find(params[:id])
    @mailbox.destroy

    respond_to do |format|
      format.html { redirect_to(domain_mailboxes_path(@domain), :notice => 'Mailbox was successfully deleted.') }
      format.xml  { head :ok }
    end
  end

  private

  def get_domain
    @domain = Domain.find(params[:domain_id])
  end

  def _add_crumbs
    add_crumb 'Domains', domains_path
    add_crumb @domain.domain, domain_path(@domain)
    add_crumb 'Mailboxes', (domain_mailboxes_path(@domain) unless params[:action] == "index")
  end

end
