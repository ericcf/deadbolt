module Deadbolt
  require 'deadbolt/engine' if defined? Rails

  mattr_accessor :root_options
  @@root_options = { :controller => "Deadbolt::Home", :action => "index" }

  def self.setup
    yield self
  end
end
