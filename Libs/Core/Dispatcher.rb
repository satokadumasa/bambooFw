class Libs < BaseClass
	class Core < BaseClass
		class Dispatcher < BaseClass
			def initialize config
				@project_root = config.project_root
			end
		end
	end
end
