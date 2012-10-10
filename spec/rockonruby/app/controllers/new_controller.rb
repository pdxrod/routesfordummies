class NewController < ApplicationController

  def an_action 
    @array = url2array params 
    @hash = params2hash params
    # Error checking 
    raise "The first part of the URL after '/new/' should be 'foo'!!!'" unless @array[ 0 ] == 'foo'
    raise "The parameter list should include 'situation'!!!" unless @hash.keys.include? 'situation'
    @params = params.dup # See new/an_action.html.erb
    # Select private methods to call based on what is in the hash and the array 
  end       

# Fake db activity by just writing to a temp file
  def put_action
    str = params[ :what ]
    file = File.open( TMPFILE_PATH, 'w' )
    file.write( str )
    file.close
  end

  def post_action
    raise( "#{TMPFILE_PATH} does not exist!!!" ) unless File.exist? TMPFILE_PATH
    str = params[ :what ]
    file = File.open( TMPFILE_PATH, 'w' )
    file.write( str )
    file.close
  end

  def delete_action
    raise( "#{TMPFILE_PATH} does not exist!!!" ) unless File.exist? TMPFILE_PATH
    File.delete TMPFILE_PATH
    raise( "#{TMPFILE_PATH} exists!!!" ) if File.exist? TMPFILE_PATH
  end
  
 private 

end

