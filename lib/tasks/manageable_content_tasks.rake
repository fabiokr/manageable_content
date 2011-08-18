namespace :manageable_content do

  desc "Generates ManageableContent::Page (check documentation for ManageableContent::Manager.generate!)"
  task :generate => :environment do
    locales     = ManageableContent::Engine.config.locales
    puts "Generating pages for locales #{locales}..."

    controllers = ManageableContent::Manager.generate!

    puts controllers.map{ |controller| "  #{controller}" }.join("\n")
  end

end