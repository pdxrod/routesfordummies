class DummyController < ApplicationController

  def an_action      
    @array = url2array params 
    @hash = params2hash params                       
    @params = params.dup 
  end       

end

