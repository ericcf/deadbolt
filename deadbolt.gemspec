lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "deadbolt/version"

Gem::Specification.new do |spec|
  spec.name = "deadbolt"
  spec.version = Deadbolt::VERSION
  spec.summary = "Authentication/authorization based on Devise and CanCan."
  spec.authors = ["Eric Carty-Fickes"]
  spec.files = Dir["{app,config,public,lib}/**/*"]

  spec.add_dependency("devise", ["~> 1.1.3"])
  spec.add_dependency("cancan", ["~> 1.4.0"])
  spec.add_dependency("formtastic", ["~> 1.1.0"])
end
