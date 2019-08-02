class Libs < BaseClass
	class Core < BaseClass
		class Router < BaseClass
			def initialize config
				@project_root = config.project_root
				@config = config
				@logger = Libs::Utils::Logger.new(@project_root)
				yaml = YAML.load_file(@project_root + "config/routes.yml")
				@yaml = yaml['routes']
        @logger.log('debug', ['Libs::Core::Router', 'initialize', "yaml:#{yaml}"])
        @logger.log('debug', ['Libs::Core::Router', 'initialize', "config:#{config.inspect}"])
        @default_actions = config.app['default_actions']
        @logger.log('debug', ['Libs::Core::Router', 'initialize', "default_actions:#{@default_actions.inspect}"])
			end

			def generate_routes
				@routes = []
				@yaml.each do |arr|
	        arr_route = []
					controller_name = ''
					action = ''
	        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "arr:#{arr}"])
	        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "CH-00"])
	        if arr[1].include?('#')
		        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "CH-01"])
	        	arr_route =arr[1].split('#')
		        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "arr_route[#{arr_route.inspect}]"])
	        	action = arr_route[1]
		        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "action:#{action}"])
	        	controller = arr_route[0]
		        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "Controller#actions controller[#{controller}]"])
		        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "Controller#actions config[#{@config.inspect}]"])
	        	uri = @config.server['base_uri'] + controller + '/' + action
	        	controller_name = "Apps::Controllers::#{controller.to_camel}Controller"
	        	@routes.push({uri => {'controller' => controller_name, 'action' => action}})
		        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "Welcome.index"])
	        else
		        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "CH-02"])
						controller = arr[1]
		        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "Controller.actions controller[#{controller}]"])
	        	controller_name = controller
	        	controller_name = "Apps::Controllers::#{controller_name.to_camel}Controller"

			      @default_actions.each do |action|
		        	uri = @config.server['base_uri'] + controller + '/' + action
		        	@routes.push({uri => {'controller' => controller_name, 'action' => action}})
			      end
		      end
	        # @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "routes:#{@routes.inspect}"])
				end
        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "routes:#{@routes}"])
				# @routes
			end

			def find_route(uri)
				@routes[uri]
			end
		end
	end
end
