project_root = File.expand_path("../../", __FILE__) + '/'
p "project_root:#{project_root}"
libs_path = project_root + 'Libs/'
vendor_path = project_root + 'Vendor/'
app_path = project_root + 'Apps/'
$LOAD_PATH.push(libs_path)
$LOAD_PATH.push(vendor_path)
$LOAD_PATH.push(app_path)
# puts "LOAD_PATH:" + $LOAD_PATH.inspect
# require 'Core/Autoloder.rb'
autoload :BambooServer, 'BambooServer/BambooServer.rb'
require 'Apps.rb'
require 'Libs.rb'
require 'autoload.rb'
logger = Libs::Utils::Logger.new(project_root)
logger.log('debug', ['bamboo', 'main', 'files:'])
# puts "LOAD_PATH:" + $LOAD_PATH.inspect
config = Libs::Core::Config.new(project_root)
server = BambooServer::Lib::Server.new(config)
# server.main
