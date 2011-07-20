class MailAliasesController < ApplicationController

  before_filter :get_domain, :_add_crumbs
  
  def index
    @mail_aliases = @domain.mail_aliases.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mail_aliases }
    end
  end

  def show
    @mail_alias = @domain.mail_aliases.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mail_alias }
    end
  end

  def new
    @mail_alias = @domain.mail_aliases.build
    add_crumb "New"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mail_alias }
    end
  end

  def edit
    @mail_alias = @domain.mail_aliases.find(params[:id])
    add_crumb "Edit"
  end

  def create
    @mail_alias = @domain.mail_aliases.build(params[:mail_alias])
    add_crumb "New"

    respond_to do |format|
      if @mail_alias.save
        format.html { redirect_to(domain_mail_alias_path(@domain, @mail_alias), :notice => 'Mail alias was successfully created.') }
        format.xml  { render :xml => @mail_alias, :status => :created, :location => @mail_alias }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mail_alias.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @mail_alias = @domain.mail_aliases.find(params[:id])
    add_crumb "Edit"

    respond_to do |format|
      if @mail_alias.update_attributes(params[:mail_alias])
        format.html { redirect_to(domain_mail_alias_path(@domain, @mail_alias), :notice => 'Mail alias was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mail_alias.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @mail_alias = @domain.mail_aliases.find(params[:id])
    @mail_alias.destroy

    respond_to do |format|
      format.html { redirect_to(domain_mail_alias_path(@domain), :notice => 'Mail alias was successfully deleted.') }
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
    add_crumb 'Aliases', (domain_mail_aliases_path(@domain) unless params[:action] == "index")
  end

end
