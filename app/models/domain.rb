class Domain < ActiveRecord::Base
  belongs_to :site
  default_scope where(:active => true)
  
  def name=(value)
    self[:name] = value.downcase
  end
end
