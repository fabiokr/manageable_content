Dummy::Application.routes.draw do

  match "home"    => "home#index",      :as => 'home'
  match "contact" => "contact#index",   :as => 'contact'
  match "blog"    => "blog/home#index", :as => 'blog_home'

  match "admin"   => "admin/home#index", :as => 'admin_home'

end
