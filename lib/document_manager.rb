class DocumentManager
  
  def self.mkdir(name)
    begin
      dir = dir_name(name)
      Dir::mkdir(dir) if !FileTest::directory?(dir)
    end
  end
  class << self
    alias_method :touch_dir, :mkdir
  end
  
  def self.rmdir(name, force = false)
    dir = dir_name(name)
    begin
      File.delete(*Dir[File.join(dir, "*")]) if force
      Dir.rmdir(dir)
    end
  end
  
  def self.ls(name)
    begin
      Dir.entries( dir_name(name) ) - [".", ".."]
    end
  end
  
  private
  def self.dir_name(data)
    return File.join([Rails.root, data].flatten)
  end
end
