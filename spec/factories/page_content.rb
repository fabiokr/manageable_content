FactoryGirl.define do
  factory :page_content, :class => ManageableContent::PageContent do
    page
    key     'content-key'
    content  { "The #{page.id} #{key} content" }
  end
end