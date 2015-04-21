require 'yaml'

configure :development, :production do
  set :public_folder, Proc.new { File.join root, "public/dist" }
end

configure :development do
  config = YAML.load_file('config/database.yml')["development"]
  ActiveRecord::Base.establish_connection(
    adapter: config["adapter"],
    database: config["database"]
  )
end

configure :production do
  config = YAML.load_file('config/database.yml')["production"]
  ActiveRecord::Base.establish_connection(
    adapter: config["adapter"],
    database: config["database"],
    username: config["username"],
    password: config["password"],
    encoding: config["encoding"]
  )
end

configure :test do
  config = YAML.load_file('config/database.yml')["test"]
  ActiveRecord::Base.establish_connection(
    adapter: config["adapter"],
    database: config["database"]
  )
end
