source 'http://rubygems.org'

gem 'rails'

gem 'mysql2', '~> 0.2.11'

gem 'haml'
gem 'devise'
gem 'cancan'
gem 'formtastic', '~> 2.0.0.rc3'

group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'rspec-rails', '>= 2.0.0'
  gem 'webrat'
  gem 'shoulda'
  gem 'factory_girl'
  # Rails 3 support
  gem 'factory_girl_rails'
  if RUBY_VERSION =~ /1.9/
    gem 'ruby-debug19', :require => 'ruby-debug'
    gem 'simplecov'
  end
end
