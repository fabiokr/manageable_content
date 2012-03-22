class StaticPagesController < ApplicationController

  manageable_content_custom_key do
    params[:page]
  end

  def index
  end

end