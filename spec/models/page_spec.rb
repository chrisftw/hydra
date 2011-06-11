require 'spec_helper'

describe Page do
  
  before(:all) do
    @site_1 = Site.create(:name => "Test Site 1", :layout => "default")
    @site_2 = Site.create(:name => "null site", :layout => "null")
    
    Page.create(:site => @site_1, :name => "bunny_ninja", :data => "bazinga")
    Page.create(:site => @site_2, :name => "carrot_eater", :data => "YUM")
    Page.create(:site => @site_1, :name => "super_rabbit", :data => "a bird or a plane")
    Page.create(:site => @site_1, :name => '404', :data => "PAGE MISSING")
    
    $site = @site_1
  end
  
  after(:all) do
    Site.delete_all
    Page.delete_all
  end
  
  it "should clean page names" do
    Page.clean_name("PiCKLe-SALad").should == "pickle_salad"
    Page.clean_name("PiCKLe SALad").should == "pickle_salad"
    Page.clean_name("Bunny Ninja").should == "bunny_ninja"
    Page.clean_name("bunny_ninja").should == "bunny_ninja"
  end
  
  it "should get pages" do
    page = Page.get_page("bunny_ninja")
    page.data.should == "bazinga"
    
    page = Page.get_page("Bunny Ninja")
    page.data.should == "bazinga"
  end
  
  it "should find 404 page if 404 exists, and requested page does not" do
    page = Page.get_page("fuzzy_bunny")
    page.name.should == '404'
    
    page = Page.get_page("carrot_eater")
    page.name.should == '404'
  end
  
  it "should not find the page if no page or 404" do
    $site = @site_2
    page = Page.get_page("carrot_eater")
    page.should_not == nil
    page.data.should == "YUM"
    page = Page.get_page("missing_page")
    page.should == nil
    $site = @site_1
  end
  
  it "should create a backup hash" do
    page = Page.get_page("bunny_ninja")
    hash = page.to_backup_hash
    hash["data"].should == "bazinga"
    hash["name"].should == "bunny_ninja"
    hash["site_id"].should == nil
    hash["id"].should == nil
  end
  
  it "should create a page from a hash" do
    site = Site.create(:name => "onionsoup")
    backup_hash = {:name => "buzzy_bee", :data => "The Bee Buzzes"} 
    page = Page.from_backup_hash(backup_hash, site.id)
    site.pages.length.should == 1
    page.id.should_not == nil
    page.site.should == site
  end
  
end
