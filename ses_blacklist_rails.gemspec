$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ses_blacklist_rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ses_blacklist_rails'
  s.version     = SesBlacklistRails::VERSION
  s.authors     = ['mrdShinse']
  s.email       = ['shinse.tanaka@gmail.com']
  s.homepage    = 'https://github.com/mrdShinse/ses_blacklist_rails'
  s.summary     = 'AWS SES blacklist for Rails applications.'
  s.description = 'Handling SES notifications like Bounce or Complaint.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 4.1 ', '< 5.2'

  s.add_development_dependency 'sqlite3'
end
