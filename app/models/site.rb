class Site < ActiveRecord::Base
  has_many :domains
  has_many :pages
  has_many :site_users
  has_many :users, :through => :site_users
  default_scope where(:active => true)
  
  def self.current(domain_name = nil)
    site_id = current_id(domain_name)
    return nil if site_id.nil?
    return Site.find(site_id)
  end
  
  def self.current_id(domain_name = nil)
    domain = Domain.where("name = ?", domain_name.downcase).first
    return domain && domain.site_id
  end
end
