class ManageableContent::Page < ActiveRecord::Base
  attr_accessible

  validates :locale, :presence => true

  has_many :page_contents

  # Retrieves a Page object for the given key and locale.
  # By default I18n.locale is used as the locale option. 
  def self.for_key(key, locale = I18n.locale)
    includes(:page_contents)
      .where(:key => key)
      .where(:locale => locale)
      .first
  end
end
