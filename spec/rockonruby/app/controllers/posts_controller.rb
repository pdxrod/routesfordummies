class PostsController < ApplicationController

  def post_action # See integration test restful_verb_test for what this is about -    
                  # POST "posts/foo/bar?a=not_foo" with params {:a => 'still_not_foo'} 
    @array = url2array  
    @hash = params2hash 
    @params = params.dup 

# puts "\n array[ 0 ] = #{@array[ 0 ]}, params[ 'a' ] = #{@params[ 'a' ]}, hash[ 'a' ] = #{@hash['a']}\n"
# puts " request.POST = #{request.POST}, request.GET = #{request.GET}\n"

    raise "request.POST[ 'a' ] should be '#{ POSTS_PARAM }'" unless request.POST[ 'a' ] == POSTS_PARAM
    raise "request.GET[ 'a' ] should not be '#{ POSTS_PARAM }'" if request.GET[ 'a' ] == POSTS_PARAM

    raise "array[ 0 ] should be 'foo' not '#{ @array[ 0 ] }'" unless @array[ 0 ] == 'foo'
    raise "params[ 'a' ] should be 'foo' not '#{ @params[ 'a' ] }'" unless @params[ 'a' ] == 'foo'
    raise "hash[ 'a' ] should be '#{ POSTS_PARAM }' not '#{ @hash[ 'a' ] }'" unless @hash[ 'a' ] == POSTS_PARAM

  end       

end

