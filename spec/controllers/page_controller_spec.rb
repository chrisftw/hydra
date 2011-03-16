require 'spec_helper'

describe PageController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'error'" do
    it "should be successful" do
      get 'error'
      response.should be_success
    end
  end

end
