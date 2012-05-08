class AddDefaultMailboxQuotaToDomains < ActiveRecord::Migration
  def change
    add_column :virtual_domains, :default_mailbox_quota, :integer, :default => 0
  end
end
