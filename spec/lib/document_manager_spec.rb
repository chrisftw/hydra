require 'spec_helper'

describe DocumentManager do
  
  before(:all) do
    
  end
  
  after(:all) do
    
  end
  
  it "should make directories" do
    DocumentManager.mkdir(["spec", "lib", "document_manager_test_dir"])
    FileTest::directory?(File.join(Rails.root, "spec", "lib", "document_manager_test_dir"))
  end
  
  it "should list directory contents" do
    DocumentManager.ls(["spec", "lib"]).include?("document_manager_spec.rb").should == true
  end
  
  it "should remove directories" do
    entry_count = DocumentManager.ls(["spec", "lib"]).length
    DocumentManager.rmdir(["spec", "lib", "document_manager_test_dir"])
    DocumentManager.ls(["spec", "lib"]).length.should == entry_count - 1
  end
  
end
