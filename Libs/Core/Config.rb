require 'yaml'

class Libs < BaseClass
	class Core < BaseClass
		class Config < BaseClass
			attr_accessor :server, :project_root, :app
			def initialize project_root
				yaml = YAML.load_file(project_root + "/config/app.yml")
				@server = yaml['server']
				@project_root = project_root
				@logger = Libs::Utils::Logger.new(project_root)
				@logger.log('debug', ['Libs::Core::Config', 'initialize', "yaml:#{yaml.inspect}"])
				@app = yaml['app']
				port = server['port'] == 80 ? '' : ":#{server['port'].to_s}"
				@base_uri = server['base_uri']
				@logger.log('debug', ['Libs::Core::Config', 'initialize', "base_url:#{@base_url}"])
			end
		end
	end
end
