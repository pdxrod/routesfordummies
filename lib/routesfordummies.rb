module Routesfordummies 

SLASH = '/'
COLON = ':'
DOT = '.'

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
    str = ':a'
    chr = 96.chr
    rts = { }
#   get 'new/:a'        => 'new#an_action'
#   get 'new/:a/:b'     => 'new#an_action'
# etc.
    until chr == 'y'
      chr = (chr.ord + 1).chr
      str = str + SLASH + COLON + chr unless chr == 'a' 
      pat = con + SLASH + str
      rts[ pat ] = "#{con}##{act}" 
    end
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

  def url2array( params )
    arr = []
    chr = 'a'
    val = params[ chr ]
    until val.nil?
      ord = chr.ord
      ndx = ord - 97
      arr[ ndx ] = val
      chr = (ord + 1).chr
      val = params[ chr ]
    end
    arr
  end	  	  

  def params2hash( params )
    arr = params.dup
    chr = 'a'
    val = params[ chr ]
    until val.nil?
      arr.delete chr 
      ord = chr.ord
      chr = (ord + 1).chr
      val = params[ chr ]
    end
    arr.delete 'action'
    arr.delete 'controller'
    arr
  end
	  
end

