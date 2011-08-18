class ApplicationController < ActionController::Base
  include ManageableContent::Controllers::Dsl

  protect_from_forgery

  manageable_layout_content_for :footer_copyright, :footer_contact
  manageable_content_for :title, :keywords
end
