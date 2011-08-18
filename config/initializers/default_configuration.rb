# Configures the managable locales available for the application.
# This is used while generating pages; So, if the application needs a page version
# for the English and Portuguese locales, the following should be set in an initializer:
#
#   ManageableContent::Engine.config.locales = [:en, :pt]
#
ManageableContent::Engine.config.locales = [I18n.locale]