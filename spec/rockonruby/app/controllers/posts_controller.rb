class PostsController < ApplicationController

  def post_action      
    @array = url2array  
    @hash = params2hash                        
    @params = params.dup 
  end       

end

