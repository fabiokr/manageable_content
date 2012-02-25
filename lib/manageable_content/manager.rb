module ManageableContent
  class Manager

    # Retrieves a list of Controllers eligible for having manageable content.
    # A Controller is eligible if it has set contents with :manageable_content_for.
    # This method is cached if Rails.configuration.cache_classes is true.
    def self.eligible_controllers
      if Rails.configuration.cache_classes
        @@eligible_controllers ||= find_eligible_controllers
      else
        find_eligible_controllers
      end
    end

    # Generates a Page and PageContent for each Controller with manageable content keys,
    # and the layout Page for manageable layout content keys.
    def self.generate!
      controllers = eligible_controllers

      Engine.config.locales.each do |locale|
        # layout page
        Controllers::Dsl.manageable_layout_content_keys.each_key do |layout|
          generate_page! layout,
                              locale,
                              Controllers::Dsl.manageable_layout_content_keys[layout]
        end

        # controllers pages
        controllers.each do |controller_class|
          generate_page! controller_class.controller_path,
                              locale,
                              controller_class.manageable_content_keys
        end
      end

      controllers
    end

    # Retrieves a Page relation with a filter for eligible Pages.
    # A Page is eligible if the corresponding controller is still eligible
    # (from the eligible_controllers method).
    #
    # This method should be used to access a list of valid Pages instead of directly accessing the
    # Page model.
    def self.pages
      Page.where(:key =>
            eligible_controllers.map {|controller_class| controller_class.controller_path })
    end

    # Retrieves a Page relation for the given key and locale.
    # By default I18n.locale is used as the locale option.
    def self.page(key, locale = I18n.locale)
      Page.with_contents.where(:key => key, :locale => locale)
    end

    # Retrieves a list of eligible keys for a given Page key.
    # This can be useful to check if a PageContent is still relevant
    # based on the current configurations.
    #
    # This will return a list of page keys with it's corresponding content type (:string or :text).
    def self.eligible_contents(key)
      layout_content_keys = Controllers::Dsl.manageable_layout_content_keys[key] || {}
      content_keys        = begin
        "#{key.camelize}Controller".constantize.manageable_content_keys
      rescue NameError
        []
      end

      layout_content_keys.merge(content_keys)
    end

    protected

    # Retrieves a list of Controllers eligible for having manageable content.
    # A Controller is eligible if it has set contents with :manageable_content_for.
    def self.find_eligible_controllers
      controllers.uniq.select do |controller_class|
       controller_class.respond_to?(:manageable_content_keys) &&
        controller_class.manageable_content_keys.present?
      end.sort do |controller_a, controller_b|
        controller_a.name <=> controller_b.name
      end
    end

    # Generates a Page and PageContent for the given key, locale and content keys.
    def self.generate_page!(key, locale, content_keys)
      Rails.logger.info "Generating ManageableContent::Page for key '#{key}',
        locale '#{locale}' and keys [#{content_keys.keys.join(',')}]"

      Page.transaction do
        page = Manager.page(key, locale).first || Page.new

        if page.new_record?
          page.key    = key
          page.locale = locale
          page.save!
        end

        content_keys.each do |content_key, content_type|
          page_content       = page.page_content(content_key) || page.page_contents.build
          page_content.key   = content_key
          page_content.short = content_type == :string
        end

        page.save!
      end
    end

    def self.controllers
      Rails.configuration.paths["app/controllers"].expanded.inject([]) do |controllers, dir|
        controllers += Dir["#{dir}/**/*_controller.rb"].map do |file|
          file.gsub("#{dir}/", "").gsub(".rb", "").camelize.constantize
        end
      end
    end
  end
end