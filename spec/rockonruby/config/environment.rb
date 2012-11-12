# Load the rails application
require File.expand_path('../application', __FILE__)
# Initialize the rails application
Rockonruby::Application.initialize!

# Rails.logger = Logger.new( Rails.env == 'production' ? File.join(Rails.root,'logger.log') : STDOUT ) 
Rails.logger = Logger.new( File.join(Rails.root, 'log', 'logger.log') ) 

