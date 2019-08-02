class Libs < BaseClass
	class Core < BaseClass
		class Dispatcher < BaseClass
			def initialize(config, uri, method_type, params)
				puts "Dispatcher.initialize config[#{config.inspect}]"
				@config = config
				@uri = uri
				@method_type = method_type
        @params = params
				@project_root =@config.project_root
				@logger = Libs::Utils::Logger.new(@project_root)
				puts "Dispatcher.initialize project_root[#{@project_root}]"
        @logger.log('debug', ['Libs::Core::Dispatcher', 'initialize', "End"])
			end

			def dispatch
				content = ''
        @logger.log('debug', ['Libs::Core::Dispatcher', 'dispatch', "Start"])
				router = Libs::Core::Router.new(@config)
				router.generate_routes

        @logger.log('debug', ['Libs::Core::Dispatcher', 'dispatch', "End"])
				content = 'content'
			end
		end
	end
end
