puts "Start Bamboo"
project_root = File.expand_path("../../", __FILE__) + '/'

libs_path = project_root + 'Libs/'
vendor_path = project_root + 'Vendor/'
app_path = project_root + 'Apps/'
$LOAD_PATH.unshift(project_root)
$LOAD_PATH.unshift(libs_path)
$LOAD_PATH.unshift(vendor_path)
$LOAD_PATH.unshift(app_path)

begin
	require 'Libs/Core/BaseClass.rb'
	require 'BambooServer/BambooServer.rb'
	require app_path + 'Apps.rb'
	require libs_path + 'Libs.rb'
	require 'autoload.rb'
	require 'Utils/conv_camel_snake.rb'
rescue Exception => e
	puts e.message
end
logger = Libs::Utils::Logger.new(project_root)
logger.log('debug', ['bamboo', 'main', 'files:'])
config = Libs::Core::Config.new(project_root)
server = BambooServer::Lib::Server.new(config)
server.main_proc
