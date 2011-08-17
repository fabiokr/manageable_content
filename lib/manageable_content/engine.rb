require 'rails'
require 'manageable_content/controllers/dsl'
require 'manageable_content/generator'

module ManageableContent

  def self.table_name_prefix
    'manageable_content_'
  end

  class Engine < Rails::Engine
  end
end
