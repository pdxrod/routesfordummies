class DummyController < ApplicationController

  def an_action      
    @array = url2array  
    @hash = params2hash                        
    @params = params.dup 
  end       

end

