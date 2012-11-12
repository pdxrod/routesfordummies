require 'fileutils'

require File.dirname( __FILE__ ) + '/../app/helpers/application_helper'
include ApplicationHelper
     
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

class Object
  def fixture_path ; '.' ; end
  def transactional_fixtures ; false ; end
  def instantiated_fixtures ; false ; end
  def fixture_path=( f ) ; end
  def use_transactional_fixtures=( t ) ; end
  def use_instantiated_fixtures=( u ) ; end
end

AR = ENV['RAILS_ROOT']+'/activerecord/lib/active_record.rb'
module InactiveRecord
  require AR
  include ActiveRecord
end
require AR
include ActiveRecord

AM = ENV['RAILS_ROOT']+'/activemodel/lib/active_model.rb'
class InactiveModel
  require AM
  include ActiveModel
end
require AM
include ActiveModel

old_meths = ActiveModel.methods.sort

# See http://www.ruby-forum.com/topic/2530
Object.instance_eval{ remove_const :ActiveRecord }
Object.instance_eval{ remove_const :ActiveModel }

class ActiveModel < InactiveModel
end
module ActiveRecord 
  TestFixtures=InactiveRecord
end

new_meths = ActiveModel.new.methods.sort

meths = old_meths - new_meths
raise "The module hasn't got many more methods than the class" unless meths.size > 20
[ :attr_internal, :attr_internal_accessor, :attr_internal_reader, :attr_internal_writer ].each do |sym|
  raise "The module doesn't have method :#{sym.to_s}" unless old_meths.include?( sym )
end

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


