class Libs < BaseClass
	class Core < BaseClass
		class BaseController < BaseClass
			def initialize(config, params)
				super(config)
				@config = config
				@params = params
			end
		end
	end
end
