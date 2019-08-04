class Apps < BaseClass
	class Controllers < BaseClass
		class WelcomeController < Libs::Core::BaseController
			def initialize(config)
				super(config)
				@config = config
				@logger.log('debug',['Apps::Controllers::WelcomeController','initialize', 'END'])
			end

			def index
				@data = []
				begin
					user = Apps::Models::User.new(@config)
					# @data.push({'users' => user.all()})
					@data['Users'] = user.find_all
					@logger.log('debug',['Apps::Controllers::WelcomeController','index', "data:#{@data.inspect}"])
				rescue Exception => e
					@logger.log('debug',['Apps::Controllers::WelcomeController','index', "Error:#{e.message}"])
				end
				@data
			end
		end
	end
end
