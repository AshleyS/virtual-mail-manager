class RenameDomainsDomainColumnToName < ActiveRecord::Migration
  def self.up
    rename_column :domains, :domain, :name
  end

  def self.down
    rename_column :domains, :name, :domain
  end
end
