require 'yaml'

class Libs < BaseClass
	class Core < BaseClass
		class Config < BaseClass
			attr_accessor :server, :project_root
			def initialize project_root
				yaml = YAML.load_file(project_root + "/config/app.yml")
				@server = yaml['server']
				@project_root = project_root
				@logger = Libs::Utils::Logger.new(project_root)
				@logger.log('debug', ['Libs::Core::Config', 'initialize', "yaml:#{yaml.inspect}"])
			end
		end
	end
end
