require 'spec_helper'

describe Domain do
  
  before(:all) do
    @site_1 = Site.create(:name => "Test Site 1", :layout => "default")
    @dom1 = Domain.create(:name => "localhost", :site_id => @site_1.id)
    dom2 = Domain.create(:name => "example.com", :site_id => @site_1.id)
    
    @site_2 = Site.create(:name => "null site", :layout => "null")
    dom_3 = Domain.create(:name => "0.0.0.0", :site_id => @site_2.id)
  end
  
  after(:all) do
    Site.delete_all
    Domain.delete_all
  end
  
  it "should set domain names correctly" do
    dom = Domain.new(:name => "ChrisReister.COM")
    dom.name.should == "chrisreister.com"
  end
  
  it "should create a backup hash" do
    hash = @dom1.to_backup_hash
    hash["name"].should == "localhost"
    hash["site_id"].should == nil
    hash["id"].should == nil
  end
  
  it "should create a domain from a hash" do
    site = Site.create(:name => "onionsoup")
    backup_hash = {:name => "buzzy_bee", :data => "The Bee Buzzes"} 
    page = Page.from_backup_hash(backup_hash, site.id)
    site.pages.length.should == 1
    page.id.should_not == nil
    page.site.should == site
  end
  
end
