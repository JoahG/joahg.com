Joahg::Application.routes.draw do
  root :to => 'p#index'
  get "about" => "p#about", :as => "about"
  get "find" => "p#find", :as => "find"
end
