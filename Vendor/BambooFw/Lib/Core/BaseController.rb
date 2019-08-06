require 'net/http'

class BambooFw < BaseClass
	class Lib < BaseClass
		class Core < BaseClass
			class BaseController < BaseClass
				attr_accessor :view_data
				def initialize(config, params)
					super(config)
					@config = config
					@params = params
					@view_data = {}
				end
			end
		end
	end
end