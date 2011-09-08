source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

gem 'mysql2'

gem 'haml'
gem 'devise'
gem 'cancan'
gem 'formtastic', '~> 2.0.0.rc'

group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'rspec-rails', '>= 2.0.0'
  gem 'webrat'
  gem 'shoulda', '>= 3.0.0.beta'
  gem 'factory_girl'
  # Rails 3 support
  gem 'factory_girl_rails'
  if RUBY_VERSION =~ /1.9/
    gem 'ruby-debug19', :require => 'ruby-debug'
    gem 'simplecov'
  end
end
