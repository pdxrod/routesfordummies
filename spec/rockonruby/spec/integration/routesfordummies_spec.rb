require 'spec_helper'
require File.expand_path('../../../test/spec_and_test_helper', __FILE__)

describe "routesfordummies" do

# Method routes_prepend caused routing error
  it "should fail after a routes prepend with no reload_routes" do
    routes_prepend	  
    begin
      get ABCDEG_PATH
      false.should be_true  # This line should not be reached
    rescue Exception => err # but this line very much SHOULD be
      raise "OMG!?!! WTF!#! This is the wrong error: '#{err.message}'!" unless err.message =~ /No.*route.*matches.*/mi 
    end
  end

  it "should succeed after a routes prepend followed by a routes draw with reload_routes" do
    routes_draw 
    get ABCDEG_PATH
    response.should be_success
  end

  it "should now work" do
    get ABCDEG_PATH
    response.should be_success
  end

end



