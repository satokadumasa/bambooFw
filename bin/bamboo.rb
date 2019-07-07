project_root = File.expand_path("../../", __FILE__)
p project_root
require project_root + '/lib/bamboo/core/Config.rb'
require project_root + '/lib/bamboo/core/bamboo_server.rb'
config = Config.new(project_root)
server = BambooServer.new(config)
server.main

p 'CH-01'