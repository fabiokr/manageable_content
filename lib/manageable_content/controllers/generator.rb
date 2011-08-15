module ManageableContent
  module Controllers
    class Generator

      # Generates a Page and PageContent for each Controller with manageable content keys,
      # and the layout Page for manageable layout content keys.
      #
      def self.generate!
        controllers = eligible_controllers

        # layout page
        Engine.config.locales.each do |locale|
          self.generate_page! nil, locale, ManageableContent::Controllers::Dsl.manageable_layout_content_keys

          # controllers pages
          controllers.each do |controller_class|
            self.generate_page! controller_class.controller_path, locale, controller_class.manageable_content_for
          end
        end
      end

      protected

        # Retrieves a list of Controllers eligible for having manageable content.
        # A Controller is eligible if it responds to the :manageable_content_for method.
        #
        def self.eligible_controllers
          Rails.configuration.paths["app/controllers"].expanded.inject([]) do |controllers, dir|
            controllers += Dir["#{dir}/**/*_controller.rb"].map do |file| 
              file.gsub("#{dir}/", "")
                  .gsub(".rb", "")
                  .camelize
                  .constantize
            end
          end.uniq.select{ |controller_class| controller_class.respond_to?(:manageable_content_for) }
        end

        # Generates a Page and PageContent for the given key, locale and content keys.
        #
        def self.generate_page!(key, locale, content_keys)
          Rails.logger.info "Generating ManageableContent::Page for key '#{key}', 
            locale '#{locale}' and keys [#{content_keys.join(',')}]"

          Page.transaction do
            page = Page.for_key(key, locale) || Page.new

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
  end
end