FactoryGirl.define do
  factory :page, :class => ManageableContent::Page do
    key     'page-key'
    locale  { ManageableContent::Engine.config.locales.sample }
  end
end