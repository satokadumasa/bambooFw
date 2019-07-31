class Libs < BaseClass
	class Core < BaseClass
		class BaseController < BaseClass
			def initialize(config)
				@logger = Libs::Utils::Logger.new(config.project_root)
			end
		end
	end
end
