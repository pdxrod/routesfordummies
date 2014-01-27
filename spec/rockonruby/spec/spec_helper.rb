require 'fileutils'

require File.dirname( __FILE__ ) + '/../app/helpers/application_helper'
include ApplicationHelper
     
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

RSpec.configure do |config|

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
#  config.order = 'random'

end

require 'rspec/rails'

  module ActiveRecord
    class Base
      def Base.logger=( l )
      end
      def Base.logger
        Logger.new( File.join(Rails.root, 'log', 'logger.log') ) 
      end
    end
  end

def load_schema
# Bug fix for something introduced by the latest edge beta 4 code
  ActiveRecord::Base.logger = Logger.new( File.join(Rails.root, 'log', 'logger.log') ) 

end


