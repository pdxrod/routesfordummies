ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require File.dirname( __FILE__ ) + '/../app/helpers/application_helper'
require File.expand_path('../spec_and_test_helper', __FILE__)

class ActiveSupport::TestCase

end


