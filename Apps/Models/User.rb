class Apps < BaseClass
	class Models < BaseClass
		class User < Libs::Core::BaseModel
			def initialize(config)
				super(config)
				@config = config
        @logger.log('debug', ['Apps::Models::User', 'initialize', "table_name:#{@table_name}"])
				p "table_name:#{@table_name}"
			end

			def find_all
				super
			# 	begin
	  #       @logger.log('debug', ['Apps::Models::User', 'all', "START"])
			# 		@users = [
			# 			[
			# 				'id' => 1,
			# 				'name' => 'ksato'
			# 			],
			# 			[
			# 				'id' => 2,
			# 				'name' => 'susanoo'
			# 			],
			# 			[
			# 				'id' => 3,
			# 				'name' => 'rain'
			# 			],
			# 			[
			# 				'id' => 4,
			# 				'name' => 'rainyrook'
			# 			],
			# 			[
			# 				'id' => 5,
			# 				'name' => 'susanoo'
			# 			]
			# 		]
	  #       @logger.log('debug', ['Apps::Models::User', 'all', "users[#{@users.inspect}]"])
			# 		return @users
			# 	rescue Exception => e
			# 		@logger.log('debug',['Apps::Models::User','all', "Error:#{e.message}"])
			# 	end
			end	
		end
	end
end
