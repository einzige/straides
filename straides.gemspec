$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "straides/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "straides"
  s.version     = Straides::VERSION
  s.authors     = ["Kevin Goslar"]
  s.email       = ["kevin.goslar@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "HTTP Status codes for Rails"
  s.description = "A more convenient way to return different HTTP status codes from Rails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "activesupport"

  # s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
