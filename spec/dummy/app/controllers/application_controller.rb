class ApplicationController < ActionController::Base
  include ManageableContent::Controllers::Dsl

  protect_from_forgery
end
