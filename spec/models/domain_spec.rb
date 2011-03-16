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
  
  it "should find a site" do
    @site = Domain.find_site("example.com")
    @site.name.should == "Test Site 1"
  end
  
end
