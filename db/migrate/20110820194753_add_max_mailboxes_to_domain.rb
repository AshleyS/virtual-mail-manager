class AddMaxMailboxesToDomain < ActiveRecord::Migration
  def self.up
    add_column :domains, :max_mailboxes, :integer
  end

  def self.down
    remove_column :domains, :max_mailboxes
  end
end
