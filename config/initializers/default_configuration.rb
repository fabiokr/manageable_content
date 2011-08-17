# Configures the managable locales available for the application.
# This is used while generating pages; So, if the application needs a page version
# for the English and Portuguese locales, the following should be set in an initializer:
#
#   ManageableContent::Engine.config.locales = [:en, :pt]
#
ManageableContent::Engine.config.locales = [I18n.locale]

# Configures the manageable contents that will be shared between all Controllers.
# For example, if all Controllers will share a 'footer_message' and a 'footer_copyright' 
# contents, the following should be set in an initializer:
#
#   ManageableContent::Engine.config.ignore_controller_namespaces :footer_message, :footer_copyright
#
ManageableContent::Engine.config.ignore_controller_namespaces = []

# Configures default content keys for all Controllers.
# For example, if all Controllers will have a 'title' and a 'keywords' contents,
# the following should be set in an initializer:
#
#   ManageableContent::Engine.config.default_contents :title, :keywords
#
ManageableContent::Engine.config.default_contents = []