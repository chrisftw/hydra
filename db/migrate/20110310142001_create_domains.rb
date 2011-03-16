class CreateDomains < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.string :name, :unique => true
      t.integer :site_id
      t.boolean :active, :default => true

      t.timestamps
    end
    
    add_index :domains, :site_id
  end

  def self.down
    drop_table :domains
  end
end
