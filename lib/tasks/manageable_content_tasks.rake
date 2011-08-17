namespace :manageable_content do

  desc "Generates ManageableContent::Page (check documentation for ManageableContent::Generator.generate!)"
  task :generate => :environment do
    ManageableContent::Generator.generate!
  end

end