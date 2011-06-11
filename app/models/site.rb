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
  
  def self.backup(site_id)
    site = Site.find(site_id)
    backup_hash = site.to_backup_hash
    backup_data = Base64.encode64(Marshal.dump(backup_hash))
    file_name = "#{Time.now.strftime("%Y%m%d%H%M%S")}.bk"
    dir = File.join(file_name)
    DocumentManager.touch_dir(["backups", site.clean_name])
    file_path = File.join(Rails.root, "backups", site.clean_name , file_name)
    begin
      f = File.open(file_path, "w")
      f.puts backup_data
      f.close
      return File.join(site.clean_name, file_name)
    rescue => err
      puts "Exception: #{err}"
      err
    end
  end
  
  def self.from_backup(file_name)
    file_name = File.join(Rails.root, "backups", file_name)
    begin
      file = File.new(file_name, "r")
      backup_hash = Marshal.load(Base64.decode64(file.read))
      file.close
    rescue => err
      puts "Exception: #{err}"
      err
    end
    from_backup_hash(backup_hash)
  end
  
  def clean_name
    name.gsub(/\s|-/, "_").downcase
  end
  
  def to_backup_hash
    backup_hash = { "site" => {} }
    col_names = Site.column_names - ["id"]
    col_names.each { |col| backup_hash["site"][col] = self.send(col.to_sym ) }
    backup_hash["domains"] = self.domains.collect{ |dom| dom.to_backup_hash }
    backup_hash["pages"] = self.pages.collect{ |page| page.to_backup_hash }
    backup_hash["users"] = self.users.collect{ |user| user.to_backup_hash }
    # will add forms here soon
    # will add form_results here soon
    backup_hash
  end
  
  def self.from_backup_hash(backup_hash)
    site = Site.new(backup_hash["site"])
    if site.save
      backup_hash["domains"].each{|dom_hash| Domain.from_backup_hash(dom_hash, site.id) }
      backup_hash["pages"].each{|page_hash| Page.from_backup_hash(page_hash, site.id) }
      backup_hash["users"].each{|user_hash| Domain.from_backup_hash(user_hash, site.id) }
      # will add forms here soon
      # will add form_results here soon
    else
      raise RuntimeError, "Unable to read/save Site #{site.inspect}"
    end
    true
  end
  
end
