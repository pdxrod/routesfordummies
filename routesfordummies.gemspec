$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "routesfordummies/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "routesfordummies"
  s.version     = Routesfordummies::VERSION
  s.authors     = ["Rod McLaughlin"]
  s.email       = ["rodmclaughlin@gmail.com"]
  s.homepage    = "http://rodmclaughlin.com"
  s.summary     = "Makes routes.rb easier to use. For Rails >= 3.1.1 and Ruby >= 1.9.0."
  s.description = "See http://rockonruby.com. Thanks to http://namick.tumblr.com/post/17663752365/how-to-create-a-gemified-plugin-with-rails-3-2-rspec."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "> 3.1.0"

  s.add_development_dependency "sqlite3"   
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
end

