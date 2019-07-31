require "date"

class Libs < BaseClass
	class Utils < BaseClass
		class Logger < BaseClass
			def initialize project_root
				@project_root = project_root
			end

			def log(type, messages)
				str = "[#{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}]"
				filename = "#{@project_root}tmp/logs/#{type}_#{DateTime.now.strftime("%Y%m%d").to_s}.log"
				messages.each do |message|
					str << " " << message
				end
				File.open(filename, "a") do |f|
					f.puts str
				end
			end
		end
	end
end
