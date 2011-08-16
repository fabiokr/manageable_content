namespace :manageable_content do

  desc "Generates ManageableContent::Page (check documentation for 
          ManageableContent::Controllers::Generator.generate!)"
  task :generate => :environment do
    ManageableContent::Controllers::Generator.generate!
  end

end