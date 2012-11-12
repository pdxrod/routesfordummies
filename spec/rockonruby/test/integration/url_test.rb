require File.expand_path('../../test_helper', __FILE__)

class UrlTest < ActionDispatch::IntegrationTest 

  def setup
    n = Rockonruby::Application.routes.routes.length
    raise "Should be 35 routes, not #{n}" unless n == 35 
    insertabcdroutes( {:app => 'Rockonruby', :controller => 'new', :action => 'an_action'} )
    n = Rockonruby::Application.routes.routes.length
    raise "Should be 60 routes, not #{n}" unless n == 60
  end
  
  def test_should_show_adding_abcdeg_url_on_the_fly
    n = Rockonruby::Application.routes.routes.length
    raise "Should be 60 routes, not #{n}" unless n == 60 
    get ABCDEG_PATH
    assert_response :success
    get ABCDEFG_PATH
    assert_response :success
    begin 
      get ABCDEFG_NO_PARAMS
    rescue Exception => r
      raise "Wrong error!!!" unless r.message =~ /.*parameter.*include.*situation.*/mi
    end 
  end

end



