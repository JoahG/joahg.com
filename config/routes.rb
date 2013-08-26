Joahg::Application.routes.draw do
  post 'sms' => "sms#index",                  :as => "sms_recieve", constraints: {subdomain: /\bgo\b.*/}
  get 'new' => "urls#new",                    :as => "new_url",     constraints: {subdomain: /\bgo\b.*/}
  get 'login' => "urls#login",                                      constraints: {subdomain: /\bgo\b.*/}
  get "logout" => "sessions#destroy",         :as => "logout",      constraints: {subdomain: /\bgo\b.*/}
  get ':short' => "urls#show",                :as => "url",         constraints: {subdomain: /\bgo\b.*/}
  get ':short/+' => "urls#info",              :as => "info_url",    constraints: {subdomain: /\bgo\b.*/}
  post 'urls' => "urls#create",                                     constraints: {subdomain: /\bgo\b.*/}
  post 'api/new' => "urls#api_create",                              constraints: {subdomain: /\bgo\b.*/}
  delete ":id" => "urls#destroy",             :as => "destroy_url", constraints: {subdomain: /\bgo\b.*/}
  get '/' => "urls#index",                                          constraints: {subdomain: /\bgo\b.*/}

  get "admin" => "admin#index",               :as => "admin",       constraints: {subdomain: /\bblog\b.*/}
  get "log_out" => "sessions#destroy",        :as => "log_out",     constraints: {subdomain: /\bblog\b.*/}
  get "admin/posts" => "admin#posts",         :as => "admin_posts", constraints: {subdomain: /\bblog\b.*/}
  get "admin/posts/new" => "posts#new",       :as => "new_post",    constraints: {subdomain: /\bblog\b.*/}
  get "admin/posts/:id/edit" => "posts#edit", :as => "edit_post", constraints: {subdomain: /\bblog\b.*/}
  get "/posts/:id" => "posts#show",           :as => "post", constraints: {subdomain: /\bblog\b.*/}
  get "/posts" => "posts#index", :as => "posts", constraints: {subdomain: /\bblog\b.*/}
  get "/tag/:tag" => "posts#tag", :as => "tag", constraints: {subdomain: /\bblog\b.*/}
  delete "/posts/:id" => "posts#destroy", :as => "destroy_post", constraints: {subdomain: /\bblog\b.*/}
  put "/posts/:id" => "posts#update", :as => "update_post", constraints: {subdomain: /\bblog\b.*/}
  post "/posts" => "posts#create", constraints: {subdomain: /\bblog\b.*/}
  match '', to: "posts#index", constraints: {subdomain: /\bblog\b.*/}

  get "g+" => "redirect#gplus", :as => "gplus"
  get "about" => "p#about", :as => "about"
  get "find" => "p#find", :as => "find"
  root :to => 'p#index'
  resources :sessions
  #match '*path', to: "p#fourofour"
end
