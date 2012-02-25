class AddQuotasToMailboxes < ActiveRecord::Migration
  def change
    add_column :mailboxes, :quota_kb, :integer
    add_column :mailboxes, :quota_messages, :integer
  end
end
