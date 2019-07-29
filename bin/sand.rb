project_root = File.expand_path("../../", __FILE__)
p project_root
require project_root + '/lib/bamboo/core/base_class.rb'
require project_root + '/lib/bamboo/core/config.rb'
require project_root + '/lib/bamboo/utils/conv_camel_snake.rb'

src = "CamlCase1ASnakeCase2B"
puts "  SRC: #{src}"
snake = src.to_snake
puts "SNAKE: #{snake}"
camel = snake.to_camel
puts "CAMEL: #{camel}"
