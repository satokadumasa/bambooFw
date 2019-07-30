class Libs < BaseClass
	class Core < BaseClass
		class Autoloader < BaseClass
			def initialize project_root
				@project_root = project_root
			end

			def regist
				get_class_files
				@class_files.each do |class_file|
    			if class_file.match(/\.rb/)
						class_name = File.basename(class_file, ".rb")
						class_name = class_name.split('/').pop
						autoload class_name.freeze, class_file
						p "autoload #{class_name}, #{class_file}"
					end
				end
			end

			def get_class_files
				app_dir = @project_root + 'Apps/**/*'
				@class_files = []
				Dir.glob(app_dir) do |file|
					@class_files.push(file) if file.match(/\.rb/)
				end
				p @class_files.inspect
				@class_files
			end
		end
	end
end
