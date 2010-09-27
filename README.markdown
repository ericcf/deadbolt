# Deadbolt

## Setup
In your host Rails app, require the CanCan, Devise and Formtastic gems:

    gem 'cancan'
    gem 'devise'
    gem 'formtastic'

Copy over and run the migrations within your host app.

Seed Permissions:

    rake deadbolt:permissions:seed

Add admin user:

    rake deadbolt:users:seed_admin[admin_email]

## Views
Deadbolt comes with view partials for the UI:

    deadbolt/shared_partials/_admin_menu.haml
    deadbolt/shared_partials/_personal.haml

Optionally, you can include the Formtastic stylesheets:

    stylesheets/formtastic.css
    stylesheets/formtastic_changes.css
