Dummy::Application.routes.draw do

  match "home"    => "home#index",      :as => 'home'
  match "contact" => "contact#index",   :as => 'contact'
  match "blog"    => "blog/home#index", :as => 'blog_home'
  match "staticpage1" => "static_pages#index", :defaults => { :page => "static/page1" }, :as => 'staticpage1'
  match "staticpage2" => "static_pages#index", :defaults => { :page => "static/page2" }, :as => 'staticpage2'

  match "admin"   => "admin/home#index", :as => 'admin_home'

end
