class BaseClass
	def initialize(config)
		@config = config
		@logger = BambooFw::Lib::Utils::Logger.new(@config.project_root)
		@logger.log('debug',['BaseClass','initialize', "initialized"])
	end

  def self.const_missing(const)
    # puts "const:#{const}"
  	constant = self.name + '::' + const.to_s
  	file_name = constant.gsub('::', '/') + '.rb'
  	require file_name
    Object.const_get constant
  end

  def dynamic_method(choice)
    send(choice)
  end
end
