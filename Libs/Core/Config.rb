require 'yaml'

class Libs
	class Core
		class Config < Libs::Core::BaseClass
			attr_accessor :server, :project_root
			def initialize project_root
				yaml = YAML.load_file(project_root + "/config/app.yml")
				@server = yaml['server']
				@project_root = project_root
			end
		end
	end
end
