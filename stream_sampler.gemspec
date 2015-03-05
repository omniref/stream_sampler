$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stream_sampler/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stream_sampler"
  s.version     = StreamSampler::VERSION
  s.authors     = ["Tim Robertson"]
  s.email       = ["support@omniref.com"]
  s.homepage    = "https://www.omniref.com/ruby/gems/stream_sampler"
  s.summary     = "ActiveRecord scopes to sample randomly from a query result."
  s.description = "Adds scopes to ActiveRecord to allow for biased and weighted random sampling from a query."
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rails", "~> 4.2.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "byebug"
end
