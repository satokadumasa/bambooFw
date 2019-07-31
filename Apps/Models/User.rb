class Apps < BaseClass
	class Models < BaseClass
		class User < Libs::Core::BaseModel
			def initialize(config)
				super(config)
				p "table_name:#{@table_name}"
			end

			def all()
				users = [
					[
						:id => 1,
						:name => 'ksato'
					],
					[
						:id => 2,
						:name => 'susanoo'
					],
					[
						:id => 3,
						:name => 'rain'
					],
					[
						:id => 4,
						:name => 'rainyrook'
					],
					[
						:id => 5,
						:name => 'rain'
					]
				]
			end	
		end
	end
end
