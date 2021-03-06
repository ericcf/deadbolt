require 'deadbolt'

Rails.application.routes.draw do
  devise_for :users, :class_name => "Deadbolt::User"

  scope :module => "deadbolt" do
    resources :users, :only => [:index, :edit, :update] do
      put "update_all", :on => :collection
    end
    resources :roles
    resources :permissions, :only => :index
  end

  root Deadbolt.root_options
end
