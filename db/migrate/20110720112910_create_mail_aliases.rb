class CreateMailAliases < ActiveRecord::Migration
  def self.up
    create_table :mail_aliases do |t|
      t.integer :domain_id
      t.string :source
      t.string :destination

      t.timestamps
    end
  end

  def self.down
    drop_table :mail_aliases
  end
end
