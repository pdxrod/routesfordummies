NEW_PATH =     "/new/foo/bar/fubar/snafu/snafu?foo=bar&situation=normal"
OLD_PATH =     "/old/foo/bar/fubar/snafu/snafu?foo=bar&situation=normal"
DUMMY_PATH =   "/dummy/one/two/hello/world/bar/fubar/snafu/snafu?bar=foo"
TMPFILE_PATH = "/tmp/routesfordummiesfile.tmp"

routes4dummies = File.dirname( __FILE__ ) + '/routesfordummies.rb'
if File.exist? routes4dummies
  require routes4dummies 
else
  require 'routesfordummies' 
end
include Routesfordummies 

module ApplicationHelper

end

