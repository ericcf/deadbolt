Dir[File.join(File.dirname(__FILE__), "../spec/support/**/*.rb")].each {|f| require f}

require File.join(File.dirname(__FILE__), "../spec/factories/email")
require File.join(File.dirname(__FILE__), "../spec/factories/user")
