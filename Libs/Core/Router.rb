class Libs < BaseClass
	class Core < BaseClass
		class Router < BaseClass
			def initialize(config)
				begin
					super(config)
					@config = config
					@project_root = @config.project_root
					@logger = Libs::Utils::Logger.new(@project_root)
					yaml = YAML.load_file(@project_root + 'config/routes.yml')
					@yaml = yaml['routes']
	        @default_actions = @config.app['default_actions']
	        @logger.log('debug', ['Libs::Core::Router', 'initialize', "default_actions:#{@default_actions.inspect}"])
				rescue Exception => e
					# puts "Libs::Core::Router.initialize Error:#{e.massage}"
				end
			end

			def generate_routes
				begin
					@routes = []
					@yaml.each do |key, value|
				  	arr_route = []
						controller_name = ''
						action = ''
		        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "CH-00"])
		        if value.include?('#')
		        	arr = value.split('#')
		        	controller = arr[0]
		        	action = arr[1]
		        	uri = key
		        	@routes.push({'uri' => uri, 'controller' => "Apps::Controllers::#{controller.to_camel}Controller", 'action' => action, 'method' => 'GET'})
		        	@routes.push({'uri' => uri, 'controller' => "Apps::Controllers::#{controller.to_camel}Controller", 'action' => action, 'method' => 'POST'})
			      else
							controller = value
				      @default_actions.each do |action|
				      	if action == 'index'
					      	action = '/' 
				        	uri = @config.server['base_uri'] + controller + '/' 
				      	elsif action == 'show' || action == 'edit' || action == 'delete'
				        	uri = @config.server['base_uri'] + controller + '/' + action + '/' 
				        else
				        	uri = @config.server['base_uri'] + controller + '/' + action
					      end

			        	@routes.push({'uri' => uri, 'controller' => "Apps::Controllers::#{controller.to_camel}Controller", 'action' => action, 'method' => 'GET'})
			        	unless action == 'index' || action == 'show'
				        	@routes.push({'uri' => uri, 'controller' => "Apps::Controllers::#{controller.to_camel}Controller", 'action' => action, 'method' => 'POST'})
			        	end
				      end
			      end
					end
	        # @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "routes:#{@routes}"])
				rescue Exception => e
	        @logger.log('debug', ['Libs::Core::Router', 'generate_routes', "Error:#{e.message}"])
				end
			end

			def find_route(uri, method_type)
				uri = uri.to_snake
				begin
					@routes.each do |route|
		        @logger.log('debug', ['Libs::Core::Router', 'find_route', "route.uri[#{route['uri']}]"])
		        @logger.log('debug', ['Libs::Core::Router', 'find_route', "uri[#{uri}]"])
		        @logger.log('debug', ['Libs::Core::Router', 'find_route', "start_with[#{(uri.start_with? route['uri'])}]"])
		        @logger.log('debug', ['Libs::Core::Router', 'find_route', "route.uri[#{route['uri']}] route.method[#{route['method']}]"])
						if ((uri.start_with? route['uri']) && (method_type == route['method']))
			        @logger.log('debug', ['Libs::Core::Router', 'find_route', "route[#{route.inspect}]"])
							return route
						end
					end
				rescue Exception => e
		       @logger.log('debug', ['Libs::Core::Router', 'find_route', e.message])
				end
			end
		end
	end
end
