Dummy::Application.routes.draw do

  match "home"    => "home#index"
  match "contact" => "contact#index"
  match "blog"    => "blogs/home#index"

  match "admin"   => "admin/home#index"

end
