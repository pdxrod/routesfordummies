require File.expand_path('../../test_helper', __FILE__)

class RestfulverbTest < ActionDispatch::IntegrationTest 

  def setup
    insertabcdroutes( :verb => 'get', :app => 'Rockonruby', :controller => 'new', :action => 'an_action' )
    insertabcdroutes( :verb => 'put', :app => 'Rockonruby', :controller => 'new', :action => 'put_action' )
    insertabcdroutes( :verb => 'post', :app => 'Rockonruby', :controller => 'new', :action => 'post_action' )
    insertabcdroutes( :verb => 'delete', :app => 'Rockonruby', :controller => 'new', :action => 'delete_action' )
  end
  
# If you POST "posts/foo/bar?a=not_foo" with params {:a => 'still_not_foo'} where route
# post => ":a/:b" has been set by routesfordummies, potentially, parameter 'a' could have
# one of three different values - 'foo' (from the route), 'not_foo' (from the params at the end 
# of the URL, and 'still_not_foo' (from the POST params). They should be treated differently. 
  def test_should_show_put_post_params_get_read_separately_from_url_params
    post POSTS_PATH, POSTS_PARAMS 

  end

  def test_should_show_put_post_and_delete
    File.delete TMPFILE_PATH if File.exist? TMPFILE_PATH
    rnd = (rand(666)+1).to_s
    put PUT_PATH, {:what => rnd}
    assert_response :success
    str = File.read( TMPFILE_PATH )
    assert_equal rnd, str
    rnd = (-(rnd.to_i)).to_s
    post POST_PATH, {:what => rnd}
    assert_response :success
    str = File.read( TMPFILE_PATH )
    assert_equal rnd, str
    delete DELETE_PATH
    assert_response :success
    raise( "WTF!$? #{TMPFILE_PATH} still exists!" ) if File.exist? TMPFILE_PATH
    begin
      get POST_PATH
      assert false # 'Coz we should not of gotten here
    rescue Exception => err
      raise "Wrong error message: #{err.message}!" unless err.message =~ SITUATION 
 # This shows the 'get' action 'an_action' was called, not the 'post' action, because 'an_action' is 
 # the only action which raises an error about the parameters - see new_controller
    end
  end

end



