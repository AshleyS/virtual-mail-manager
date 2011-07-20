class MailAliasesController < ApplicationController
  def index
    @domain = Domain.find(params[:domain_id])
    @mail_aliases = @domain.mail_aliases.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mail_aliases }
    end
  end

  def show
    @domain = Domain.find(params[:domain_id])
    @mail_alias = @domain.mail_aliases.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mail_alias }
    end
  end

  def new
    @domain = Domain.find(params[:domain_id])
    @mail_alias = @domain.mail_aliases.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mail_alias }
    end
  end

  def edit
    @domain = Domain.find(params[:domain_id])
    @mail_alias = @domain.mail_aliases.find(params[:id])
  end

  def create
    @domain = Domain.find(params[:domain_id])
    @mail_alias = @domain.mail_aliases.build(params[:mail_alias])

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
    @domain = Domain.find(params[:domain_id])
    @mail_alias = @domain.mail_aliases.find(params[:id])

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
    @domain = Domain.find(params[:domain_id])
    @mail_alias = @domain.mail_aliases.find(params[:id])
    @mail_alias.destroy

    respond_to do |format|
      format.html { redirect_to(domain_mail_alias_path(@domain), :notice => 'Mail alias was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
