NEW_PATH =     "/new/foo/bar/fubar/snafu/snafu?foo=bar&situation=normal"
OLD_PATH =     "/old/foo/bar/fubar/snafu/snafu?foo=bar&situation=normal"
DUMMY_PATH =   "/dummy/one/two/hello/world/bar/fubar/snafu/snafu?bar=foo"

routesfordummies = File.expand_path '../../lib/routesfordummies.rb'
if File.exists? routesfordummies
  require routesfordummies   # The latest code - this site is running inside the routesfordummies gem folder
else
  require 'routesfordummies' # The gem - downloaded from github using the Gemfile
end
include Routesfordummies 

# http://reefpoints.dockyard.com/ruby/2012/06/25/rails-4-sneak-peek-queueing.html
class MyQueue
  def push( job )
    job.run
  end
end

module ApplicationHelper
end

