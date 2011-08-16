class ApplicationController < ActionController::Base
  include ManageableContent::Controllers::Dsl

  manageable_ignore_controller_namespaces :admin
  manageable_layout_content_for           'application', :footer_copyright, :footer_contact
  manageable_default_content_for          :title, :keywords

  protect_from_forgery
end
