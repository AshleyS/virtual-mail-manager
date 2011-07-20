class DomainsController < ApplicationController

  before_filter :_add_crumbs

  def index
    @domains = Domain.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @domains }
    end
  end

  def show
    @domain = Domain.find(params[:id])
    add_crumb @domain.domain

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @domain }
    end
  end

  def new
    @domain = Domain.new
    add_crumb 'New'

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @domain }
    end
  end

  def edit
    @domain = Domain.find(params[:id])
    add_crumb @domain.domain, domain_path(@domain)
    add_crumb 'Edit'
  end

  def create
    @domain = Domain.new(params[:domain])
    add_crumb 'New domain'

    respond_to do |format|
      if @domain.save
        format.html { redirect_to(@domain, :notice => 'Domain was successfully created.') }
        format.xml  { render :xml => @domain, :status => :created, :location => @domain }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @domain = Domain.find(params[:id])
    add_crumb @domain.domain, domain_path(@domain)
    add_crumb 'Edit'

    respond_to do |format|
      if @domain.update_attributes(params[:domain])
        format.html { redirect_to(@domain, :notice => 'Domain was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @domain = Domain.find(params[:id])
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to(domains_url) }
      format.xml  { head :ok }
    end
  end

  private

  def _add_crumbs
    add_crumb 'Domains', (domains_path unless params[:action] == "index")
  end
end
