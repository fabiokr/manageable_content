class ApplicationController < ActionController::Base
  include ManageableContent::Controllers::Dsl

  protect_from_forgery

  manageable_layout_content_for :footer_contact,   :type => :string
  manageable_layout_content_for :footer_copyright, :type => :text

  manageable_content_for :title,    :type => :string
  manageable_content_for :keywords, :type => :text
end
