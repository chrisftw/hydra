class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name
      t.boolean :active, :default => true
      t.string :layout, :default => "default"
      t.string :sites, :favicon, :default => "/images/fav-hydra.png"
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
