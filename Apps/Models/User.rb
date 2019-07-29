class User < Libs::Core::BaseModel
	def initialize(config)
		super(config)
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