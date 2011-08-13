module ManageableContent

  def self.table_name_prefix
    'manageable_content_'
  end

  class Engine < Rails::Engine
  end
end
