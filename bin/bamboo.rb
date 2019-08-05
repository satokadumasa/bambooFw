puts "Start Bamboo"
project_root = File.expand_path("../../", __FILE__) + '/'

vendor_path = project_root + 'Vendor/'
app_path = project_root + 'Apps/'
$LOAD_PATH.unshift(project_root)
$LOAD_PATH.unshift(vendor_path)
$LOAD_PATH.unshift(app_path)

begin
	require 'BambooFw/Lib/Core/BaseClass.rb'
	require 'Apps.rb'
	require 'BambooFw/BambooFw.rb'
	require 'BambooServer/BambooServer.rb'
	require 'BambooFw/Lib/Utils/conv_camel_snake.rb'
rescue Exception => e
	puts e.message
end
logger = BambooFw::Lib::Utils::Logger.new(project_root)
logger.log('debug', ['bamboo', 'main', 'files:'])
config = BambooFw::Lib::Core::Config.new(project_root)
server = BambooServer::Lib::Server.new(config)
server.main_proc
