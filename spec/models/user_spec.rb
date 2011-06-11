require 'spec_helper'

describe User do
  
  before(:all) do
    @site_1 = Site.create(:name => "Test Site 1", :layout => "default")
    site_2 = Site.create(:name => "Test Site 2", :layout => "default")
    @super_user = User.create(:email => "ckent@dailyplanet.com", :password => "taco")
    @super_user.permission_mask = 131
    @super_user.save
    @site_admin = User.create(:email => "admin@test.com", :password => "pickle_juice", :username => "bazinga_user")
    @site_admin.permission_mask = 32
    @site_admin.save
    @standard_user = User.create(:email => "joe.user@yahoo.com")
    @standard_user.permission_mask = 2
    @standard_user.save
    @site_user = SiteUser.create(:site => @site_1, :user => @site_admin)
  end
  
  after(:all) do
    Site.delete_all
    SiteUser.delete_all
    User.delete_all
  end
  
  it "should check if you have a role" do
    @super_user.role_of(:super_user).should == true
    @super_user.role_of(:site_admin).should == false
    @standard_user.role_of(:site_admin).should == false
    @site_admin.role_of(:site_admin).should == true
  end
  
  it "should not allow hackers to set permissions" do
    hacker_admin = User.create(:email =>"hacker@gmail.com", :permission_mask => 255)
    hacker_admin.role_of(:super_user).should == false
    hacker_admin.role_of(:site_admin).should == false
    hacker_admin.role_of(:guest).should == true
  end
  
  it "should find all sites you can admin" do
    @super_user.all_sites.length.should == 2
    @site_admin.all_sites.length.should == 1
    @standard_user.all_sites.length.should == 0
  end
  
  it "should created a select array for all_sites" do
    @site_admin.all_sites_select[0].class.should == Array
    @site_admin.all_sites_select[0][0].should == "Test Site 1"
  end
  
  it "should create a backup hash" do
    hash = @site_admin.to_backup_hash
    hash["email"].should == "admin@test.com"
    hash["permission_mask"].should == 32
    hash["id"].should == nil
  end
  
  it "should create a page from a hash" do
    site = Site.create(:name => "onionsoup")
    backup_hash = {"name" => "beeteater", "email" => "admin@sample.com",
      "encrypted_password" => "$2a$10$xS0hR3hVvejk8JmBa6SUI.rUUoKRiyYOvQBTXSTWP8hleqks0GzFu",
      "username" => "bettywhite", "permission_mask" => 32 }
    user = User.from_backup_hash(backup_hash, site.id)
    site.users.length.should == 1
    user.id.should_not == nil
    user.sites[0].should == site
  end
end
