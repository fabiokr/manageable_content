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

  # Generates a Page and PageContent for each Controller with manageable content keys,
  # and the layout Page for manageable layout content keys.
  #
  def self.generate!
    AbstractController::Base.descendants.each do |controller_class|
      controller_path = controller_class.controller_path

      if controller_class.respond_to?(:manageable_content_for) && !controller_class.manageable_content_for.empty?
        self.generate_page! controller_path, I18n.locale, controller_class.manageable_content_for
      end

      if controller_class.respond_to?(:manageable_layout_content_for) && !controller_class.manageable_layout_content_for.empty?
        self.generate_page! nil, I18n.locale, controller_class.manageable_layout_content_for
      end
    end
  end

  # Retrieves a PageContent with the given key.
  # 
  def page_content_for_key(key)
    key = key.to_s
    page_contents.detect { |page_content| page_content.key == key }
  end

  private

    def self.generate_page!(key, locale, content_keys)
      self.transaction do
        page = self.for_key(key) || self.new

        if page.new_record?
          page.key    = key
          page.locale = locale
          page.save!
        end

        content_keys.each do |content_key|
          if page.page_content_for_key(content_key).nil?
            page_content     = page.page_contents.build
            page_content.key = content_key
          end
        end

        page.save!
      end
    end
end
