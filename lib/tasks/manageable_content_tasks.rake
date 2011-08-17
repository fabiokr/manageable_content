namespace :manageable_content do

  desc "Generates ManageableContent::Page (check documentation for ManageableContent::Generator.generate!)"
  task :generate => :environment do
    locales     = ManageableContent::Engine.config.locales
    controllers = ManageableContent::Generator.generate!

    output  = ["Pages generated for locales #{locales}:"]
    controllers.each {|controller| output << "  #{controller}"}

    puts output.join("\n")
  end

end