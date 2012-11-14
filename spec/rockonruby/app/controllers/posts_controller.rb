class PostsController < ApplicationController

  def post_action # See the integration tests for what this is about -    
                  # POST "posts/foo/bar?a=not_foo" with params {:a => 'still_not_foo'} 
    @array = url2array  
    @hash = params2hash params                        
    @params = params.dup 

puts "\n array[ 0 ] = #{@array[ 0 ]}, params[ 'a' ] = #{@params[ 'a' ]}, hash[ 'a' ] = #{@hash['a']}\n"

    raise "array[ 0 ] should be 'foo' not '#{ @array[ 0 ]}'" unless @array[ 0 ] == 'foo'
    raise "params[ 'a' ] should be 'not_foo' not '#{ @params[ 'a' ]}'" unless @params[ 'a' ] == 'not_foo'
    raise "hash[ 'a' ] should be '#{ POSTS_PARAM }' not '#{ @hash[ 'a' ]}'" unless @hash[ 'a' ] == POSTS_PARAM

  end       

end

