module ManageableContent
  module Controllers
    module Dsl
      extend ActiveSupport::Concern

      included do
        class_attribute :manageable_content_keys
      end

      module ClassMethods

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
