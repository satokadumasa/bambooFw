class Libs < BaseClass
	class Core < BaseClass
		class Router < BaseClass
			def initialize config
				@project_root = config.project_root
				@logger = Libs::Utils::Logger.new(@project_root)
				yaml = YAML.load_file(@project_root + "/config/routes.yml")
        @logger.log('debug', ['Libs::Core::Router', 'initialize', "yaml:#{yaml}"])
				@server = yaml['routes']
			end
		end
	end
end
