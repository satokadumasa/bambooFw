class Libs < BaseClass
	class Core < BaseClass
		class Dispatcher < BaseClass
			def initialize(config, uri, method_type, params)
				begin
					super(config)
					puts "Dispatcher.initialize config[#{config.inspect}]"
					@config = config
					@uri = uri
					@method_type = method_type
	        @params = params
					@project_root =@config.project_root
				rescue Exception => e
					puts "Libs::Core::Dispatcher.initialize :#{e.message}"
				end
			end

			def dispatch
				begin
					content = ''
					router = Libs::Core::Router.new(@config)
					router.generate_routes
					route = router.find_route(@uri, @method_type)
	        @logger.log('debug', ['Libs::Core::Dispatcher', 'dispatch', "route:#{route.inspect}"])
	        @logger.log('debug', ['Libs::Core::Dispatcher', 'dispatch', "params:#{@params.inspect}"])
					controller = Object.const_get(route['controller']).new(@config, @params)
					data = controller.dynamic_method(route['action'])
					view = Libs::Core::View.new(@config, data, route['controller'], route['action'])
					view_str = view.render
					view_str
				rescue Exception => e
	        @logger.log('debug', ['Libs::Core::Dispatcher', 'dispatch', "Error:#{e.message}"])
					
				end
			end
		end
	end
end
