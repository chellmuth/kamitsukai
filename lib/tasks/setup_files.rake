desc "Setup required config files"
task :setup do
  if Rails.env.test? || Rails.env.development?
    FileUtils.cp('config/database.example.yml', 'config/database.yml') unless File.exist?('config/database.yml')
  end
end

task :environment => :setup

