$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ses_blacklist_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ses_blacklist_rails"
  s.version     = SesBlacklistRails::VERSION
  s.authors     = ["mrdShinse"]
  s.email       = ["shinse1128@hotmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SesBlacklistRails."
  s.description = "TODO: Description of SesBlacklistRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "sqlite3"
end
