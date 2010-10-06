# Deadbolt

## Setup
In your host Rails app, require the CanCan, Devise and Formtastic gems:

    gem 'cancan'
    gem 'devise'
    gem 'formtastic'

Require Deadbolt:

    gem 'deadbolt', :path => '/path/to/deadbolt'

Copy over and run the migrations within your host app.

Seed Permissions:

    rake deadbolt:permissions:seed

Add Permissions for new classes:

    rake deadbolt:permissions:create[BlogPost]

Add admin user:

    rake deadbolt:users:seed_admin[admin_email]

Configure root route in an initializer (the default is Deadbolt::Home#index):

    require 'deadbolt'
    Deadbolt.setup do |config|
      config.root_options = { :controller => "Site", :action => "index" }
    end

## Views
Deadbolt comes with view partials for the UI:

    deadbolt/shared_partials/_admin_menu.haml
    deadbolt/shared_partials/_personal.haml

Optionally, you can include the Formtastic stylesheets:

    stylesheets/formtastic.css
    stylesheets/formtastic_changes.css

## Testing
Deadbolt supports testing via RSpec.  To make testing within the host app easier, add integration helpers and Factory Girl factories by adding the following line to your spec_helper.rb file:

    require 'deadbolt_spec_support'

Then, you can use the sign_in_user and sign_out_user methods in your request specs:

    include AuthenticationHelpers
    sign_in_user
    sign_out_user
    sign_in_user :admin => true
