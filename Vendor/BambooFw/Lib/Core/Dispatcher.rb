class BambooFw < BaseClass
	class Lib < BaseClass
		class Core < BaseClass
			class Dispatcher < BaseClass
				def initialize(config, uri, method_type, params)
					begin
						super(config)
						# puts "Dispatcher.initialize config[#{config.inspect}]"
						@config = config
						@uri = uri
						@method_type = method_type
		        @params = params
						@project_root =@config.project_root
					rescue Exception => e
						puts "BambooFw::Lib::Core::Dispatcher.initialize :#{e.message}"
					end
				end

				def dispatch
					begin
						content = ''
						router = BambooFw::Lib::Core::Router.new(@config)
						router.generate_routes
						route = router.find_route(@uri, @method_type)
		        # @logger.log('debug', ['BambooFw::Lib::Core::Dispatcher', 'dispatch', "route:#{route.inspect}"])
		        # @logger.log('debug', ['BambooFw::Lib::Core::Dispatcher', 'dispatch', "params:#{@params.inspect}"])
		        @params['method_type'] = @method_type
		        @logger.log('debug', ['BambooFw::Lib::Core::Dispatcher', 'dispatch', "CH-01"])
						controller = Object.const_get(route['controller']).new(@config, @params)
		        @logger.log('debug', ['BambooFw::Lib::Core::Dispatcher', 'dispatch', "CH-02"])
						controller.dynamic_method(route['action'])
		        @logger.log('debug', ['BambooFw::Lib::Core::Dispatcher', 'dispatch', "CH-03"])
						view_data = controller.view_data
						return view_data if view_data.include?('Location: ')
		        # @logger.log('debug', ['BambooFw::Lib::Core::Dispatcher', 'dispatch', "view_data:#{view_data.inspect}"])
						view = BambooFw::Lib::Core::View.new(@config, view_data, route['controller'], route['action'])
						view_str = view.render
		        @logger.log('debug', ['BambooFw::Lib::Core::Dispatcher', 'dispatch', "CH-04"])
						view_str
					rescue Exception => e
		        @logger.log('debug', ['BambooFw::Lib::Core::Dispatcher', 'dispatch', "Error:#{e.message}"])
						
					end
				end
			end
		end
	end
end