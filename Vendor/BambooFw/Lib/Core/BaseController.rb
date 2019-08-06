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
				begin
					@view_data = "Location: #{@config.base_url}#{uri}"

				rescue Exception => e
					@logger.log('debug',['Apps::Controllers::UsersController','redirect_to', "Error:#{e.message}"])
				end
		  end
		end
	end
end