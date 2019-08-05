class Apps < BaseClass
	class Controllers < BaseClass
		class WelcomeController < BambooFw::Lib::Core::BaseController
			def initialize(config, params)
				super(config, params)
				# @config = config
				@logger.log('debug',['Apps::Controllers::WelcomeController','initialize', 'END'])
			end

			def index
				begin
					user = Apps::Models::User.new(@config)
					users = user.find_all
					@view_data['Users'] = users
				rescue Exception => e
					@logger.log('debug',['Apps::Controllers::WelcomeController','index', "Error:#{e.message}"])
				end
				@data
			end
		end
	end
end
