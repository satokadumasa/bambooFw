class Libs
	class Core
		class BaseClass
		  def self.const_missing(const)
		    file_name = const
		    p "file_name:" + file_name.to_s
		    require file_name.to_s
		    p "require:" + file_name.to_s
		    puts "const_missing(#{const.inspect})"
		    super(const)
		  end
		end
	end
end
