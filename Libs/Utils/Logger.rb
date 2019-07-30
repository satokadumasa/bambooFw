require "time"

class Libs < BaseClass
	class Utils < BaseClass
		class Logger < BaseClass
			def initialize project_root
				@project_root = project_root
			end

			def log(type, messages)
				p Date.today.strftime("%Y-%m-%d %H:%M:%S").to_s
				str = "[#{Date.today.strftime("%Y-%m-%d %H:%M:%S")}]"
				filename = "#{@project_root}tmp/logs/#{type}_#{Date.today.strftime("%Y%m%d").to_s}.log"
				messages.each do |message|
					str << " " << message
				end
				File.open(filename, "w") do |f|
					f.puts str
				end
			end
		end
	end
end
