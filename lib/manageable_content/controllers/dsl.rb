module ManageableContent
  module Controllers
    module Dsl
      extend ActiveSupport::Concern
        
      mattr_accessor :manageable_ignore_controller_namespace_keys,
                     :manageable_layout_content_keys, 
                     :manageable_default_content_keys
                     
      self.manageable_layout_content_keys, self.manageable_default_content_keys = {}, []

      included do
        class_attribute :manageable_content_keys
        self.manageable_content_keys = []

        helper_method :manageable_layout_content_for
        helper_method :manageable_content_for
      end

      module ClassMethods

        # Configures the manageable contents that will be shared between all Controllers.
        # For example, if all Controllers will share a 'footer_message' and a 'footer_copyright' 
        # contents, the following should be set on a high level Controller (e.g. ApplicationController):
        #
        #   manageable_layout_content_for :footer_message, :footer_copyright
        #
        def manageable_ignore_controller_namespaces(*keys)
          unless keys.empty?
            Dsl.manageable_ignore_controller_namespace_keys = keys.uniq
          end
        end

        # Configures default content keys for all Controllers.
        # For example, if all Controllers will have a 'title' and a 'keywords' contents,
        # the following should be set:
        #
        #   manageable_default_content_for :title, :keywords
        #
        def manageable_default_content_for(*keys)
          unless keys.empty?
            Dsl.manageable_default_content_keys = keys.uniq
          end
        end

        # Configures the manageable contents that will be shared between all Controllers that
        # use a given layout.
        # For example, if all Controllers using the application layout will share a 'footer_message' 
        # and a 'footer_copyright' contents, the following should be set:
        #
        #   manageable_layout_content_for 'application', :footer_message, :footer_copyright
        #
        def manageable_layout_content_for(layout, *keys)
          unless keys.empty?
            Dsl.manageable_layout_content_keys[layout] = keys.uniq
          end
        end

        # Configures the manageable contents for a Controller.
        # For example, if the Controller will have a 'body' and a 'side' contents,
        # the following should be set:
        #
        #   manageable_content_for :body, :side
        #
        def manageable_content_for(*keys)
          unless keys.empty?
            self.manageable_content_keys = keys.uniq
          end
        end
      end

      module InstanceMethods

        # Retrieves the content for the current page with a given key.
        #
        def manageable_content_for(key)
          @page ||= ManageableContent::Page.for_key(controller_path)
          manageable_content_for_page @page, key
        end

        # Retrieves the content for the current layout with a given key.
        #
        def manageable_layout_content_for(key)
          @layout_page ||= ManageableContent::Page.for_key(_layout)
          manageable_content_for_page @layout_page, key
        end

        private

          def manageable_content_for_page(page, key)
            page.try(:page_content_for_key, key).try(:content).try(:html_safe)
          end
      end
    end
  end
end