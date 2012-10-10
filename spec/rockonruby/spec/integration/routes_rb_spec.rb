require 'spec_helper'

describe "routesfordummies" do

  it "should succeed if it's a routesfordummies params hash" do
    get NEW_PATH
    response.should be_success  
    begin
      get OLD_PATH # fails                      
      false.should be_true
    rescue ActionController::RoutingError  
    end
    # get 'new/:a/:b'      
    params = {'a' => 'bar', 'b' => 'bar', 'd' => 'foo'} # 'c' is missing, so 'd' is not part of an :a/:b/:c routes schema
    arr = url2array params
    arr.size.should == 2
    arr[0].should == 'bar'
    arr[1].should == 'bar'
  end                                     
  
  it "should produce empty array if it's not a routesfordummies params hash" do
    # get 'old/:version/:scope/:id/media.:format'
    params = {'version' => '1', 'scope' => 'foo', 'id' => 'bar', 'format' => 'json'}	  
    arr = url2array params
    arr.size.should == 0 
  end  
  
  it "should produce a hash of non-routesfordummies values" do
    # get 'new/:a/:b/:c'      
    params = {'action' => 'an_action', 'controller' => 'new', 
	      'a' => 'bar', 'b' => 'bar', 'd' => 'foo', 'version' => '1', 'scope' => 'foo', 'id' => 'bar', 'format' => 'json'}	  
    params.keys.size.should == 9 
    arr = url2array params
    arr.size.should == 2
    hsh = params2hash params
    hsh.keys.size.should == (9 - 2 - 2) # 'action' and 'controller' are removed
    hsh[ 'format' ].should === 'json' 
    hsh[ 'd' ] .should == 'foo' # 'd' was not in the a:/:b/:c series, so it must have been a POST or ?...& parameter
  end  

end


