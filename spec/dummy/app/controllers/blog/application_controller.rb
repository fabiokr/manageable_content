class Blog::ApplicationController < ActionController::Base
  include ManageableContent::Controllers::Dsl
  
  protect_from_forgery
  layout 'blog'

  manageable_layout_content_for :blog_title, :layout => 'blog'
end
