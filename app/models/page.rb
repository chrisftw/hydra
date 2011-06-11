class Page < ActiveRecord::Base
  belongs_to :site
  default_scope where(:active => true)
  
  RESERVED_PAGE_NAMES = ["admin", "error", "images", "javascripts", "stylesheets"]
  
  def self.clean_name(name = nil)
    return 'home' if name.nil?
    return name.gsub(/\s|-/, "_").downcase
  end
  
  def self.get_page(name = nil)
    page = Page.where(:name => clean_name(name), :site_id => $site.id).first
    return page || Page.where(:name => '404', :site_id => $site.id).first
  end
  
  def to_backup_hash
    backup_hash = {}
    column_names = Page.column_names - ["id", "site_id"]
    column_names.each { |col| backup_hash[col] = self.send(col.to_sym ) }
    backup_hash
  end
  
  def self.from_backup_hash(backup_hash, site_id)
    page = Page.new(backup_hash)
    page.site_id = site_id
    if page.save
      return page
    else
      raise RuntimeError, "Unable to read/save Page #{page.inspect}"
    end
  end
end
