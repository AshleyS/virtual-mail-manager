class CreateAdministrations < ActiveRecord::Migration
  def change
    create_table :administrations do |t|
      t.integer :user_id
      t.integer :domain_id

      t.timestamps
    end
  end
end
