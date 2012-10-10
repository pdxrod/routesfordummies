require 'fileutils'

require File.dirname( __FILE__ ) + '/../app/helpers/application_helper'
include ApplicationHelper
        
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'


