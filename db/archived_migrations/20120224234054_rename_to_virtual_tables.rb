class RenameToVirtualTables < ActiveRecord::Migration
  def up
    rename_table "domains", "virtual_domains"
    rename_table "mailaliases", "virtual_aliases"
    rename_table "mailboxes", "virtual_users"
  end

  def down
    rename_table "virtual_domains", "domains"
    rename_table "virtual_aliases", "mailaliases"
    rename_table "virtual_users", "mailboxes"
  end
end
