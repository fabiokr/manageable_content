ManageableContent::Engine.config.locales      = [:en, :pt]
ManageableContent::Engine.config.custom_pages = {
  "static/page1" => {:body => :text},
  "static/page2" => {:body => :text, :footer => :string}
}