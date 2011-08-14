module ManageableContent
  module Controllers
    module Dsl
      extend ActiveSupport::Concern

      included do
        class_attribute :manageable_content_keys
        mattr_accessor  :manageable_layout_content_keys

        helper_method :manageable_content_for
      end

      module ClassMethods

        # Configures the manageable contents for a Controller.
        # For example, if the Controller will have a 'body' and a 'side' contents,
        # the following should be set:
        #
        #   manageable_content_for :body, :side
        #
        # This can also be called without parameters, in which case this will return the current 
        # manageable content keys for the Controller.
        #
        def manageable_content_for(*keys)
          manageable_content :manageable_content_keys, keys
        end

        # Configures the manageable contents that will be shared between all Controllers.
        # For example, if all Controllers will share a 'footer_message' and a 'footer_copyright' 
        # contents, the following should be set on a high level Controller (e.g. ApplicationController):
        #
        #   manageable_layout_content_for :footer_message, :footer_copyright
        #
        # This can also be called without parameters, in which case this will return the current 
        # manageable layout content keys.
        #
        def manageable_layout_content_for(*keys)
          manageable_content :manageable_layout_content_keys, keys
        end

        private

          def manageable_content(attribute, keys)
            unless keys.empty?
              self.send("#{attribute}=", keys)
            end

            self.send(attribute) || []
          end
      end

      module InstanceMethods

        # Retrieves the content for the current page with a given key.
        # This will first look for a PageContent with the given key within
        # the layout page contents, and if none is found, it will look
        # within the page contents for the current controller.
        #
        def manageable_content_for(key)
          @layout_page ||= ManageableContent::Page.for_key(nil)
          @page        ||= ManageableContent::Page.for_key(controller_path)

          (@layout_page.try(:content_for_key, key) || @page.try(:content_for_key, key))
            .try(:content)
            .try(:html_safe)
        end
      end
    end
  end
end