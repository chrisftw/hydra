class CreateSiteUsers < ActiveRecord::Migration
  def self.up
    create_table :site_users do |t|
      t.integer :site_id
      t.integer :user_id
      t.boolean :active

      t.timestamps
    end
    
    add_index :site_users, :site_id
    add_index :site_users, :user_id
  end

  def self.down
    drop_table :site_users
  end
end
