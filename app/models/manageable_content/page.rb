class ManageableContent::Page < ActiveRecord::Base
  validates :locale, :presence => true

  has_many :page_contents, :dependent => :delete_all

  scope :with_contents, lambda { includes(:page_contents).joins(:page_contents) }

  attr_accessible :page_contents_attributes
  accepts_nested_attributes_for :page_contents

  # Retrieves a PageContent with the given key.
  def page_content(key)
    key = key.to_s
    page_contents.detect { |page_content| page_content.key == key }
  end

  # Retrieves a content with the given key.
  def content(key)
    page_content(key).try(:content)
  end

end