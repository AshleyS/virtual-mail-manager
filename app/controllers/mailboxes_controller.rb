class MailboxesController < ApplicationController
  def index
    @domain = Domain.find(params[:domain_id])
    # @mailboxes = Mailbox.all
    @mailboxes = @domain.mailboxes.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mailboxes }
    end
  end

  def show
    @domain = Domain.find(params[:domain_id])
    @mailbox = @domain.mailboxes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mailbox }
    end
  end

  def new
    @domain = Domain.find(params[:domain_id])
    # @mailbox = Mailbox.new
    @mailbox = @domain.mailboxes.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mailbox }
    end
  end

  def edit
    @domain = Domain.find(params[:domain_id])
    # @mailbox = Mailbox.find(params[:id])
    @mailbox = @domain.mailboxes.find(params[:id])
  end

  def create
    @domain = Domain.find(params[:domain_id])
    @mailbox = @domain.mailboxes.build(params[:mailbox])

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
    @domain = Domain.find(params[:domain_id])
    @mailbox = @domain.mailboxes.find(params[:id])

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
    @domain = Domain.find(params[:domain_id])
    @mailbox = @domain.mailboxes.find(params[:id])
    @mailbox.destroy

    respond_to do |format|
      format.html { redirect_to(domain_mailboxes_path(@domain), :notice => 'Mailbox was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
