ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require File.dirname( __FILE__ ) + '/../app/helpers/application_helper'

SITUATION = /.*should.*include.*situation.*/mi
ABCDEG =            'new/:a/:b/:c/:d/:e/:g'
# The above map is supposed to match the URL below - 6 elements after the controller name 'new'
ABCDEG_PATH =       "/new/foo/bar/fubar/snafu/snafu/situation?situation=normal"
# 7 elements after the controller name, empty parameter and no parameter
ABCDEFG_PATH =      "/new/foo/bar/fubar/snafu/snafu/situation/normal?situation="
ABCDEFG_NO_PARAMS = "/new/foo/bar/fubar/snafu/snafu/situation/normal"
TMPFILE_PATH =      "/tmp/routesfordummiesfile.tmp"
POSTS_PATH =        "posts/foo/bar?a=not_foo"
POSTS_PARAM = 'still_not_foo' 
POSTS_PARAMS = {:a => POSTS_PARAM}

PUT_PATH =        "/new/foo/put"
POST_PATH =       "/new/foo/post"
DELETE_PATH =     "/new/foo/delete"
OPTIONAL_ROUTES = 'new/(:a)/(:b)/(:c)/(:d)/(:e)/(:f)/(:g)/(:h)/(:i)/(:j)/(:k)/(:l)/(:m)/(:n)/(:o)/(:p)/(:q)/(:r)/(:s)/(:t)/(:u)/(:v)/(:w)/(:x)/(:y)' 
# See get_test

def routes_prepend
  Rockonruby::Application.routes.prepend do
    get ABCDEG => "new#an_action" 
  end
end

def routes_draw
  Rockonruby::Application.routes.draw do 
    get ABCDEG => "new#an_action" 
  end
  Rockonruby::Application.reload_routes!
end

class ActiveSupport::TestCase
end



