class MailaliasesController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :auth_only, :get_domain, :_add_crumbs
  
  def index
    @mailaliases = @domain.mailaliases.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def show
    @mailalias = @domain.mailaliases.find(params[:id])
  end

  def new
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

    redirect_to(domain_mailalias_path(@domain), :notice => 'Mail alias was successfully deleted.')
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

  def sort_column
    Mailalias.column_names.include?(params[:sort]) ? params[:sort] : "source"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
