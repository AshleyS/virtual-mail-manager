class AddLastLoginToVirtualUsers < ActiveRecord::Migration
  def change
    add_column :virtual_users, :last_login, :datetime, :default => nil
  end
end
