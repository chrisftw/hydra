require 'spec_helper'

describe PageController do

  before(:all) do
    @site_1 = Site.create(:name => "Test Site 1", :layout => "default")
    @page_1 = Page.create(:name => "test_page", :site_id => @site_1.id, :data => "TEST")
  end
  
  after(:all) do
    Site.delete_all
    Page.delete_all
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index', :page => "test_page"
      response.should be_success
    end
    
    it "should be successful" do
      get 'index', :page => "Test-Page"
      response.should be_success
    end
    
    it "should be successful" do
      get 'index'
      response.should be_failure
    end
  end
  
  describe "GET 'error'" do
    it "should be successful" do
      get 'error'
      response.should be_success
    end
  end

end
