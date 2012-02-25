class CreateMailboxes < ActiveRecord::Migration
  def self.up
    create_table :mailboxes do |t|
      t.integer :domain_id
      t.string :email
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :mailboxes
  end
end
