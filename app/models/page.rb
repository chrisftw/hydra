class Page < ActiveRecord::Base
  belongs_to :site
  default_scope where(:active => true)
  
  def self.clean_name(name = nil)
    return 'home' if name.nil?
    return name.gsub(/\s|-/, "_").downcase
  end
  
  def self.get_page(name = nil)
    puts "#{name.inspect} in page model"
    page = Page.where(:name => clean_name(name), :site_id => $site.id).first
    return page || Page.where(:name => '404', :site_id => $site.id).first
  end
  
  RESERVED_PAGE_NAMES = ["admin", "error", "images", "javascripts", "stylesheets"]
end
