require 'erb'

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
				@site_name = @config.app['site_name']
			end

			def render
				begin
					view_str = ''
				  controller = @controller.split('::').pop.to_s
					controller = controller.gsub!('Controller', '')
					erb_file = "#{@config.project_root}Apps/View/#{controller}/#{@action}.erb"
					@template_srt = read_template(erb_file)
					layout = "#{@config.project_root}Apps/View/Layout/default.erb"
					view_str = read_template(layout)

					return view_str
				rescue Exception => e
	        @logger.log('debug', ['Libs::Core::View', 'render', "Error:#{e.message}"])
				end
			end

			def read_template(erb_file)
				view_str = ''
				File.open(erb_file) do |file|
					file.each_line do |labmen|
						view_str << labmen
					end
				end
				
				ERB.new(view_str).result(binding)
			end

		end
	end
end