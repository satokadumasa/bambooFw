class Libs
	class Core
		class Autoloder
			def initialize project_root
				@project_root = project_root
				@dirs = ['Apps', 'Libs', 'Vender']
			end

			def get_files
				@files = []
				@dirs.each do |dir|
					dir = @project_root + dir + '/**/*' 
					p dir 
					Dir.glob(dir) do |file|
						@files.push(file) if File.extname(file) == '.rb'
					end
				end
			end

			# def regist_load_class_files
			# 	begin
			# 		autoload :Libs, 'Libs.rb'
			# 		autoload :Apps, 'Apps.rb'
			# 		autoload :Vender, 'Vender.rb'
			# 	rescue Exception => e
			# 		p "Autoloder.regist_load_class_files Error:" + e.message
			# 	end
			# end

		end
	end
end
