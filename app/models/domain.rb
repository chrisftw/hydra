class Domain < ActiveRecord::Base
  belongs_to :site
  default_scope where(:active => true)
  
  def name=(value)
    self[:name] = value.downcase
  end
  
  def to_backup_hash
    backup_hash = { }
    col_names = Domain.column_names - ["id", "site_id"]
    col_names.each { |col| backup_hash[col] = self.send(col.to_sym ) }
    backup_hash
  end
  
  def self.from_backup_hash(backup_hash, site_id)
    domain = Domain.new(backup_hash)
    domain.site_id = site_id
    if domain.save
      return domain
    else
      raise RuntimeError, "Unable to read/save Domain #{domain.inspect}"
    end
  end
end
