class AddMaxMailaliasesToDomain < ActiveRecord::Migration
  def self.up
    add_column :domains, :max_mailaliases, :integer
  end

  def self.down
    remove_column :domains, :max_mailaliases
  end
end
