class ManageableContent::Page < ActiveRecord::Base
  attr_accessible

  validates :locale, :presence => true

  has_many :page_contents

  # Retrieves a Page for the given key and locale.
  # By default I18n.locale is used as the locale option.
  #
  def self.for_key(key, locale = I18n.locale)
    includes(:page_contents)
      .where(:key => key)
      .where(:locale => locale)
      .first
  end

  # Retrieves a PageContent with the given key.
  # 
  def content_for_key(key)
    key = key.to_s
    page_contents.detect { |page_content| page_content.key == key }
  end
end
