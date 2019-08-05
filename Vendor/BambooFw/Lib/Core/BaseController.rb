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

		  def redirect_to(uri)
        @logger.log('debug', ['BambooFw::Lib::Core::BaseController', 'redirect_to', "START"])
		  	Net::HTTP.get_print @config.base_url, uri
				exit
		  end
		end
	end
end