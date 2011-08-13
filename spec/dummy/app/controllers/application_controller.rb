class ApplicationController < ActionController::Base
  include ManageableContent::Controllers::Dsl

  manageable_layout_content_for :footer_copyright, :footer_contact

  protect_from_forgery
end
