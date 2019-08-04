class Libs < BaseClass
	class Core < BaseClass
		class View < BaseClass
			def initialize(config, data, controller, action)
				super(config)
				@config = config
				@controller = controller
				@action = action
				@data = data
				@logger = Libs::Utils::Logger.new(@project_root)
			end

			def render
				begin
					view_str = ''
					@data.each do |datum|
						view_str << datum.inspect
					end
					return view_str
				rescue Exception => e
	        @logger.log('debug', ['Libs::Core::View', 'render', "Error:#{e.message}"])
				end
		end
		end
	end
end