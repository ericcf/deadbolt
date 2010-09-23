module Deadbolt

  mattr_accessor :root_path
  @@root_path = "deadbolt/home#index"

  def self.setup
    yield self
  end
end
