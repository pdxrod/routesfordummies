module Routesfordummies 

SLASH = '/'
COLON = ':'
DOT = '.'
OPEN_P = '('
CLOSE_P = ')'

# Thanks http://openhood.com/rails/rails%203/2010/07/20/add-routes-at-runtime-rails-3/
# :app => Your application as a string - eg. 'Rockonruby'
# :controller => The first part of the controller name as a string, eg. 'posts', not 'posts_controller'
# :action => A string, the name of a public method in the controller, eg. 'my_action'
# :verb => A string, 'put', 'post', 'get' or 'delete' - optional, if missing, 'get' is assumed
  def insertabcdroutes( hash )
    raise( 'This method needs a hash of parameters' ) if hash.nil?
    raise( 'This method needs an app name, eg. :app=>"Rockonruby"' ) if hash[ :app ].nil?
    raise( 'This method needs a controller name, eg. :controller=>"posts"' ) if hash[ :controller ].nil?
    raise( 'This method needs an action name, eg. :action=>"my_action"' ) if hash[ :action ].nil?
    vrb = hash[ :verb ]
    vrb = 'get' if vrb.nil?
    raise( 'This method only accepts get, put, post and delete as verbs') unless ['get', 'put', 'post', 'delete'].include? vrb 
    app = hash[:app].constantize 
    con = hash[:controller]
    act = hash[:action]
    str = '(:a)'
    chr = 96.chr
    rts = { }
    pat = ''
#   get 'new/(:a)/(:b)'     => 'new#an_action'
    until chr == 'y'
      chr = (chr.ord + 1).chr
      str = str + SLASH + OPEN_P + COLON + chr + CLOSE_P unless chr == 'a' 
    end
    pat = con + SLASH + str
puts pat
    rts[ pat ] = "#{con}##{act}" 
    app::Application.routes.prepend do 
      case vrb
        when 'get'
          rts.each { |k, v| get k => v }
        when 'put'
          rts.each { |k, v| put k => v }
        when 'post'
          rts.each { |k, v| post k => v }
        when 'delete'
          rts.each { |k, v| delete k => v }
      end
    end
    app::Application.reload_routes!
  end

  def url2array( *paths ) # Splits a url - eg. /new/my/url?param=hello produces ['my', 'url']
    path = (paths.size > 0 ? paths[ 0 ] : nil)
    path = request.fullpath if path.nil? # Useful for testing - you can give it a path - but in a controller it can find request.fullpath
 puts path
    arr, hsh = arrayandhash( path, {} )
    arr = [] if arr.nil? or arr.size < 2
    arr = arr[ 2 .. -1 ] if arr.size > 1 # Remove the controller name, eg. '/new/foo/bar' becomes ['foo', 'bar'] 
    arr
  end	  	  

PARAMS_ERR = <<-PARAMS_ERR_END
Takes either
 - no parameters - in which case it looks at request.fullpath
 - a hash - in which case it treats it as if it is hash 'params' in a controller, and finds request.fullpath
 - a string - in which case it treats it as request.fullpath - eg. "/posts/1/edit", or
 - a hash and a string, as specified above, in either order
Any other combination of parameters causes an error
It returns a hash of parameters - GET or POST
If there are POST params, they override the GET params in the return value(it is possible to have both)
Eg. if /foo/?a=a_value gets a POST request with 'a' => 'another_value', the return hash will have 'a' set to 'another_value', not 'a_value'
PARAMS_ERR_END
  def params2hash( *paths ) 
    path, params = analyze( paths )
    path = request.fullpath if path.nil? # Useful for testing - you can give it a path - but in a controller it can find request.fullpath
 puts path
    arr, hsh = arrayandhash( path, params )
    hsh
  end

 private

  def analyze( paths )
    raise PARAMS_ERR unless paths.size == 0 or paths.size == 1 or paths.size == 2
    hashes = []
    strings = []
    paths.each do |path| # Find 0 or 1 hashes, and 0 or 1 strings, but raise error if there are more
      raise PARAMS_ERR if hashes.size > 0 and path.class == Hash 
      hashes << path if path.class == Hash
      raise PARAMS_ERR if strings.size > 0 and path.class == String
      strings << path if path.class == String
    end
    hashes[ 0 ] = nil if hashes.size < 1 
    strings[ 0 ] = nil if strings.size < 1
    return strings[ 0 ], hashes[ 0 ]
  end

  def arrayandhash( path, params )
    arr = []
    hsh = {}
    raise "This method requires a URL string as a parameter - use method request.fullpath in a controller to find it" if path.nil?
    unless path.strip == ''
      parts = path.split '?'
      parts[ 0 ] = '' if parts.size < 1
      parts[ 1 ] = '' if parts.size < 2
      arr = parts[ 0 ].split '/'     # This is the URL - /foo/bar/?x=1 produces ['foo', 'bar']
      pairs = parts[ 1 ].split '&'
      pairs.each do |pair|           # These are the parameters - ?foo=&bar=snafu etc. 
        equals = pair.split '=' 
        unless equals.size < 1
          equals[ 1 ] = '' if equals.size < 2 # If the parameter list was like this: ?foo=&bar=something (foo is empty)
          hsh[ equals[ 0 ] ] = equals[ 1 ]    # This produces eg. { 'x' => '1' }
        end
      end 
    end
    request.POST.each { |k, v| hsh[ k ] = v } if (defined?( request ) and defined?( request.POST ))
    return arr, hsh
  end
	  
end

