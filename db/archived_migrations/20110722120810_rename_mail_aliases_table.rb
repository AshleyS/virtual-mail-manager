class RenameMailAliasesTable < ActiveRecord::Migration
  def self.up
    rename_table :mail_aliases, :mailaliases
  end

  def self.down
    rename_table :mailaliases, :mail_aliases
  end
end
