class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :username, :remember_me
  
  has_many :site_users
  has_many :sites, :through => :site_users
  default_scope where(:active => true)
  
  def role_of(role_names = [:standard])
    role_names = [role_names] if !role_names.kind_of? Array
    role_names.each do |role_name|
      return true if permission_mask_flag(ROLES[role_name])
    end
    return false
  end
  
  def all_sites
    if self.role_of(:super_user)
      return Site.all
    elsif self.role_of(:site_admin)
      return self.sites
    end
    return []
  end
  
  def all_sites_select
    self.all_sites.collect{ |s| [s.name, s.id]}
  end
  
  private
  def permission_mask_flag(flag)
    return (permission_mask & flag) == flag
  end
  
  roles = {:guest => 0, :standard => 2, :site_editor => 8, :site_admin => 32, :super_user => 128}
  roles.default = 0
  ROLES = roles.freeze
end
