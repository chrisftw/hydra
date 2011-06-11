require 'spec_helper'

describe Site do
  
  before(:all) do
    @site_1 = Site.create(:name => "Test Site 1", :layout => "default")
    @dom1 = Domain.create(:name => "localhost", :site_id => @site_1.id)
    dom2 = Domain.create(:name => "example.com", :site_id => @site_1.id)
    @page_1 = Page.create(:name => "bazinga", :site_id => @site_1.id, :data => "lizard")
    
    @site_2 = Site.create(:name => "null site", :layout => "null")
    dom_3 = Domain.create(:name => "0.0.0.0", :site_id => @site_2.id)
  end
  
  after(:all) do
    Site.delete_all
    Domain.delete_all
    Page.delete_all
  end
  
  it "should find the current site id from domain name" do
    site_id = Site.current_id("localhost")
    site_id.should == @site_1.id
    site_id = Site.current_id("0.0.0.0")
    site_id.should == @site_2.id
    site_id = Site.current("pickles")
    site_id.should == nil
  end
  
  it "should find the current site from domain name" do
    site = Site.current("localhost")
    site.should == @site_1
    site = Site.current("0.0.0.0")
    site.should == @site_2
    site = Site.current("pickles")
    site.should == nil
  end
  
  it "should have a clean_name" do
    @site_1.clean_name.should == "test_site_1"
  end
  
  it "should create a backup hash" do
    hash = @site_1.to_backup_hash
    hash["site"]["name"].should == "Test Site 1"
    hash["site"]["id"].should == nil
    hash["domains"].length.should == 2
    hash["pages"].length.should == 1
    hash["pages"][0]["name"].should == "bazinga"
  end
  
  it "should create a site from a hash" do
    site = Site.create(:name => "onionsoup")
    backup_hash = {:name => "buzzy_bee", :data => "The Bee Buzzes"} 
    page = Page.from_backup_hash(backup_hash, site.id)
    site.pages.length.should == 1
    page.id.should_not == nil
    page.site.should == site
  end
  
  describe "Perform backups to file" do
    it "should create a complete backup and save it to disk" do
      bk = Site.backup(@site_1.id)
      bk.include?("test_site_1/#{Time.now.strftime('%Y%m%d')}").should == true
    end
  
    it "should recover from a saved backup" do
      Site.delete_all
      Domain.delete_all
      Page.delete_all
      Site.count.should == 0
      Domain.count.should == 0
      Page.count.should == 0
      file = DocumentManager.ls(["backups", "test_site_1"])[0]
      site = Site.from_backup(File.join("test_site_1", file))
      site.should_not == nil
      Site.count.should == 1
      Domain.count.should == 2
      Page.count.should == 1
      DocumentManager.rmdir(["backups", "test_site_1"], true)
    end
  end
end
