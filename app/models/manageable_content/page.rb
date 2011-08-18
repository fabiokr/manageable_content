class ManageableContent::Page < ActiveRecord::Base
  attr_accessible

  validates :locale, :presence => true

  has_many :page_contents

  scope :with_contents, lambda { includes(:page_contents).joins(:page_contents) }

  # Retrieves a PageContent with the given key.
  # 
  def page_content_for_key(key)
    key = key.to_s
    page_contents.detect { |page_content| page_content.key == key }
  end

end