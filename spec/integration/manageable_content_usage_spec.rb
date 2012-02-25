require 'spec_helper'

describe "The demo application" do
  context "with manageable content" do
    before :each do
      ManageableContent::Manager.generate!

      # Application layout
      page = ManageableContent::Manager.page('application').first
      page.page_content(:title).update_attributes(:content => "Application Title Content")
      page.page_content(:keywords).update_attributes(:content => "Application Keywords Content")
      page.page_content(:footer_copyright).update_attributes(:content => "Application Footer Copyright Content")
      page.page_content(:footer_contact).update_attributes(:content => "Application Footer Contact Content")

      # Blog layout
      page = ManageableContent::Manager.page('blog').first
      page.page_content(:blog_title).update_attributes(:content => "Blog Application Blog Title Content")

      # Home controller
      page = ManageableContent::Manager.page('home').first
      page.page_content(:title).update_attributes(:content => "Home Title Content")
      page.page_content(:keywords).update_attributes(:content => "Home Keywords Content")
      page.page_content(:body).update_attributes(:content => "Home Body Content")
      page.page_content(:side).update_attributes(:content => "Home Side Content")

      # Contact controller
      page = ManageableContent::Manager.page('contact').first
      page.page_content(:title).update_attributes(:content => "Contact Title Content")
      page.page_content(:keywords).update_attributes(:content => "Contact Keywords Content")
      page.page_content(:body).update_attributes(:content => "Contact Body Content")
      page.page_content(:message).update_attributes(:content => "Contact Message Content")

      # Blog Home controller
      page = ManageableContent::Manager.page('blog/home').first
    end

    context "home#index" do
      it "should show correct home contents" do
        visit home_path

        within "title" do
          page.should have_content("Application Title Content Home Title Content")
        end

        within "#keywords" do
          page.should have_content("Application Keywords Content Home Keywords Content")
        end

        within "#body" do
          page.should have_content("Home Body Content")
        end

        within "#side" do
          page.should have_content("Home Side Content")
        end
      end
    end

    context "contact#index" do
      it "should show correct contact contents" do
        visit contact_path

        within "title" do
          page.should have_content("Application Title Content Contact Title Content")
        end

        within "#keywords" do
          page.should have_content("Application Keywords Content Contact Keywords Content")
        end

        within "#body" do
          page.should have_content("Contact Body Content")
        end

        within "#message" do
          page.should have_content("Contact Message Content")
        end
      end
    end

    context "blog#index" do
      it "should show correct blog contents" do
        visit blog_home_path

        within "title" do
          page.should have_content("Blog Application Blog Title Content")
        end
      end
    end
  end

end