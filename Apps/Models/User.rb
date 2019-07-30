class User 
	def initialize(config)
		# super(config)
		@table_name = self.class.name.to_s.to_snake.to_table_name
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