class Apps < BaseClass
	class Models < BaseClass
		class User < Libs::Core::BaseModel
			def initialize(config)
				super(config)
				@config = config
				p "table_name:#{@table_name}"
			end

		end
	end
end
