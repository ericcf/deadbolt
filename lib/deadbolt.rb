module Deadbolt
  require 'deadbolt/engine' if defined? Rails

  mattr_accessor :root_path
  @@root_path = "deadbolt/home#index"

  def self.setup
    yield self
  end
end
