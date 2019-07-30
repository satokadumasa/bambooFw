class BaseClass
  def self.const_missing(const)
  	constant = self.name + '::' + const.to_s
  	file_name = constant.gsub('::', '/') + '.rb'
  	require file_name
    Object.const_get constant
  end
end
