class AddUsageKbToVirtualUsers < ActiveRecord::Migration
  def change
    add_column :virtual_users, :usage_kb, :integer, :default => 0
  end
end
