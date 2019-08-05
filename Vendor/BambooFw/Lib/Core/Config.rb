require 'yaml'
require 'erb'

class BambooFw < BaseClass
	class Lib < BaseClass
		class Core < BaseClass
			class Config < BaseClass
				attr_accessor :server, :project_root, :base_url, :app
				def initialize project_root
					@logger = BambooFw::Lib::Utils::Logger.new(@project_root)
					yaml = YAML.load_file(project_root + "config/app.yml")
					@server = yaml['server']
					@project_root = project_root
					@app = yaml['app']
					port = server['port'] == 80 ? '' : ":#{server['port'].to_s}"
					@base_uri = server['base_uri']
					@base_url = "#{server['protocol']}://#{server['host']}"
					@logger.log('debug', ['BambooFw::Lib::Core::Config', 'initialize', "base_url:#{@base_url}"])
				end
			end
		end
	end
end