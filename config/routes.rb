Deadbolt::Application.routes.draw do
  devise_for :users
  root :to => Deadbolt.root_path
end
