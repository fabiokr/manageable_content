module ManageableContent
  module Controllers
    module Dsl
      extend ActiveSupport::Concern

      included do
        class_attribute :manageable_content_keys
      end

      module ClassMethods

        # Configures the manageable contents for a Controller.
        # For example, if the Controller will have a 'body' and a 'side' contents,
        # the following should be set:
        #
        #   manageable_content_for :body, :side
        #
        # This can also be called without parameters, in which case this will return the current 
        # manageable contents for the Controller.
        #
        def manageable_content_for(*keys)
          unless keys.empty?
            self.manageable_content_keys = keys
          end

          self.manageable_content_keys || []
        end

      end
    end
  end
end
