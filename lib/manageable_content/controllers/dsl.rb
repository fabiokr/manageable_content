module ManageableContent
  module Controllers
    module Dsl
      extend ActiveSupport::Concern

      mattr_accessor :manageable_layout_content_keys
      self.manageable_layout_content_keys = {}

      included do
        class_attribute :manageable_content_keys
        self.manageable_content_keys = {}

        helper_method :manageable_layout_content_for
        helper_method :manageable_content_for
      end

      module ClassMethods

        # Configures the manageable contents that will be shared between all Controllers that
        # use a given layout.
        # For example, if all Controllers using the application layout will share a 'footer_message'
        # and a 'footer_copyright' contents, the following should be set:
        #
        #   manageable_layout_content_for :footer_message, :footer_copyright
        #
        # By default, this will set contents for a layout named the same as the Controller in which
        # the manageable_layout_content_for method was called. For example, if it was called in
        # the ApplicationController, it will set the layout vars for the 'application' layout.
        # If you need to use multiple layouts with ApplicationController, you can specify
        # for which layout are the contents being set with this:
        #
        #   manageable_layout_content_for :footer_message, :footer_copyright, :layout => 'application'
        #
        # You can also set a content type for the given keys. By default they are :text content types.
        # Available types are :text for long contents and :string for short contents.
        #
        #   manageable_layout_content_for :footer_copyright, :type => :string
        #
        def manageable_layout_content_for(*keys)
          options = keys.last.is_a?(Hash) ? keys.pop : {}
          layout  = options[:layout] || self.controller_path
          type    = options[:type]   || :text

          if keys.present?
            Dsl.manageable_layout_content_keys[layout] =
              ((Dsl.manageable_layout_content_keys[layout] || {}).merge(keys_for_type(type, keys)))
          end
        end

        # Configures the manageable contents for a Controller.
        # For example, if the Controller will have a 'body' and a 'side' contents,
        # the following should be set:
        #
        #   manageable_content_for :body, :side
        #
        # This will also inherit manageable contents from superclasses. For example,
        # if all your Controllers will have a 'title' content, you can add the following
        # to ApplicationController, and all Controllers which inherit from it will have it too:
        #
        #   manageable_content_for :title
        #
        # You can also set a content type for the given keys. By default they are :text content types.
        # Available types are :text for long contents and :string for short contents.
        #
        #   manageable_content_for :title, :type => :string
        #
        def manageable_content_for(*keys)
          options = keys.last.is_a?(Hash) ? keys.pop : {}
          type    = options[:type] || :text

          if keys.present?
            self.manageable_content_keys = (self.manageable_content_keys.merge(keys_for_type(type, keys)))
          end
        end

        private

        def keys_for_type(type, keys)
          keys.inject({}) do |config, key|
            config[key] = type
            config
          end
        end
      end

      # Retrieves the content for the current layout with a given key.
      def manageable_layout_content_for(key)
        manageable_content_for_page :layout, key
      end

      # Retrieves the content for the current page with a given key.
      def manageable_content_for(key)
        manageable_content_for_page :controller, key
      end

      private

      def manageable_content_for_page(type, key)
        layout = if _layout.instance_of? String
          # Rails <= 3.1
          _layout
        else
          # Rails >= 3.2 returns something like "layout/application", so we get everything but the
          # "layout" part
          _layout.virtual_path.split('/')[(1..-1)].join('/')
        end

        @pages ||= ManageableContent::Manager.page([layout, controller_path])

        subject = type == :layout ? @pages.try(:slice, 0) : @pages.try(:slice, 1)
        subject.try(:content, key).try(:html_safe)
      end
    end
  end
end