$:.push File.expand_path("../lib", __FILE__)

require "manageable_content/version"

Gem::Specification.new do |s|
  s.name        = "manageable_content"
  s.version     = ManageableContent::VERSION
  s.authors     = ["Fabio Kreusch"]
  s.email       = ["fabiokr@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Railsadmin."
  s.description = "TODO: Description of Railsadmin."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir['spec/**/*']

  s.add_dependency "rails", "~> 3.1.0.rc5"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.5"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "database_cleaner"
  
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "guard-rspec"  
end