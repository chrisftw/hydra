class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.integer :site_id
      t.text :tags
      t.string :title
      t.text :data
      t.text :description
      t.text :tags
      t.boolean :active

      t.timestamps
    end
    
    add_index :pages, [:site_id, :name], :unique => true
  end

  def self.down
    drop_table :pages
  end
end
