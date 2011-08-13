class ContactController < ApplicationController
  
  manageable_content_for :body, :message

  def index
  end

end