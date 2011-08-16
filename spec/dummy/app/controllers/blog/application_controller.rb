class Blog::ApplicationController < ActionController::Base
  include ManageableContent::Controllers::Dsl
  
  manageable_layout_content_for 'blog/application', :blog_title

  protect_from_forgery
end
