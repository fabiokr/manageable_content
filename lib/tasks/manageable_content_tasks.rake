namespace :manageable_content do

  desc "Generates ManageableContent::Page (check documentation for ManageableContent::Generator.generate!)"
  task :generate => :environment do
    locales     = ManageableContent::Engine.config.locales
    puts "Generating pages for locales #{locales}..."

    controllers = ManageableContent::Generator.generate!

    puts controllers.map{ |controller| "  #{controller}" }.join("\n")
  end

end