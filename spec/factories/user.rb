require 'factory_girl'

Factory.define :user, :class => Deadbolt::User do |u|
  u.email Factory.next(:email)
  u.password "secret"
  u.password_confirmation "secret"
end
