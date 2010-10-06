require 'factory_girl'

Factory.sequence :email do |n|
  "person#{n}@example.com"
end
