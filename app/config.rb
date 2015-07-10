require 'erb'
require 'yaml'
module Config
        APP = YAML.load((ERB.new File.new("config/application.yml").read).result)
        ACCESS_TOKEN = APP["access_token"]
end
