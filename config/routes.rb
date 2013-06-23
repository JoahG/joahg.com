Joahg::Application.routes.draw do
  get "about" => "p#about", :as => "about"
  get "find" => "p#find", :as => "find"
  get "admin" => "admin#index", :as => "admin"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "admin/posts" => "admin#posts", :as => "admin_posts"
  get "admin/posts/new" => "posts#new", :as => "new_post"
  get "/posts/:id" => "posts#show", :as => "show_post"
  match '', to: "posts#index", constraints: {subdomain: /\bblog\b.*/}
  root :to => 'p#index'
  resources :sessions
end
