Dummy::Application.routes.draw do

  match "home"    => "home#index"
  match "contact" => "contact#index"
  match "blog"    => "blog#index"

end
