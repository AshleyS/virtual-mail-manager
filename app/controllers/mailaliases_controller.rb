class MailaliasesController < ApplicationController

  before_filter :get_domain, :_add_crumbs
  
  def index
    @mailaliases = @domain.mailaliases.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mailaliases }
    end
  end

  def show
    @mailalias = @domain.mailaliases.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mailalias }
    end
  end

  def new
    @mailalias = @domain.mailaliases.build
    add_crumb "New"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mailalias }
    end
  end

  def edit
    @mailalias = @domain.mailaliases.find(params[:id])
    add_crumb "Edit"
  end

  def create
    @mailalias = @domain.mailaliases.build(params[:mailalias])
    add_crumb "New"

    respond_to do |format|
      if @mailalias.save
        format.html { redirect_to(domain_mailalias_path(@domain, @mailalias), :notice => 'Mail alias was successfully created.') }
        format.xml  { render :xml => @mailalias, :status => :created, :location => @mailalias }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mailalias.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @mailalias = @domain.mailaliases.find(params[:id])
    add_crumb "Edit"

    respond_to do |format|
      if @mailalias.update_attributes(params[:mailalias])
        format.html { redirect_to(domain_mailalias_path(@domain, @mailalias), :notice => 'Mail alias was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mailalias.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @mailalias = @domain.mailaliases.find(params[:id])
    @mailalias.destroy

    respond_to do |format|
      format.html { redirect_to(domain_mailalias_path(@domain), :notice => 'Mail alias was successfully deleted.') }
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
    add_crumb 'Aliases', (domain_mailaliases_path(@domain) unless params[:action] == "index")
  end

end
