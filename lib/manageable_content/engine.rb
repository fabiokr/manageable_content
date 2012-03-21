require 'rails'
require 'manageable_content/controllers/dsl'
require 'manageable_content/manager'

module ManageableContent

  def self.table_name_prefix
    'manageable_content_'
  end

  class Engine < Rails::Engine
    initializer 'manageable_content.setup_locales' do |app|
      # Configures the managable locales available for the application.
      # This is used while generating pages; So, if the application needs a page version
      # for the English and Portuguese locales, the following should be set in an initializer:
      #
      #   ManageableContent::Engine.config.locales = [:en, :pt]
      #
      config.locales = [app.config.i18n.default_locale] unless config.locales.present?
    end
  end
end