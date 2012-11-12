require 'spec_helper'

describe "routesfordummies" do

  before( :all ) do
    puts
  #  ActiveRecord::Base.methods.sort.each { |m| print " #{m}" }
    puts
  end

  before(:each) do
    load_schema    
  end

  it "should succeed if it's a routesfordummies params hash" do
    get NEW_PATH
    response.should be_success  
    begin
      get OLD_PATH         # fails                      
      false.should be_true # false isn't true, but this line was never reached
    rescue ActionController::RoutingError  
    end
    path = "/new/bar/bar?d=foo"
    arr = url2array path
    arr.size.should == 2
    arr[0].should == 'bar'
    arr[1].should == 'bar'
  end                                     
  
  it "should produce array if it's not a routesfordummies params hash" do
    # get 'old/:version/:scope/:id/media.:format'
    path = "/old/1/foo/bar/?format=json"
    arr = url2array path
    arr.size.should == 3 
  end  
  
  it "should produce a hash of non-routesfordummies values" do
    # get 'new/:a/:b/:c'      
    path = "/new/bar/bar?d=foo&version=1&scope=foo&id=bar&format=json"
    arr = url2array path
    arr.size.should == 2
    hsh = params2hash path
    hsh.keys.size.should == 5
    hsh[ 'format' ].should === 'json' 
    hsh[ 'd' ] .should == 'foo' 
  end  

end


