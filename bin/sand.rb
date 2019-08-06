project_root = File.expand_path("../../", __FILE__) << '/'
# require 'cgi'
# require 'cgi/session'
# require 'securerandom'
# require 'pstore'
# session_key = SecureRandom.random_bytes(10)
# cgi = CGI.new(session_key)
# session = CGI::Session.new(cgi)
# cgi.out('charset'=>'utf-8') {
#   html = cgi.html {
#     cgi.head { cgi.title {'Form Demo'} }
#     cgi.body {
#       cgi.form('action'=>"#{CGI.escapeHTML(cgi.script_name)}") {
#         cgi.p {
#           'あなたの名前は？' +
#           cgi.text_field('name') +
#           cgi.hidden('cmd', 'hello') +
#           cgi.submit('です。')
#         }
#       }
#     }
#   }
#   CGI.pretty(html)
# }


puts "session:#{session}"

# def const_missing(name)
# 	puts "name:" + name
#   # if name.to_s =~ /^Cat/
#   #   const_set(name, Class.new(Cat))
#   # else
#   #   super
#   # end
# end

# p project_root
# libs_path = project_root + 'Libs/'
# vendor_path = project_root + 'Vendor/'
# app_path = project_root + 'Apps/'
# $LOAD_PATH.push(libs_path)
# $LOAD_PATH.push(vendor_path)
# $LOAD_PATH.push(app_path)
# begin
# 	require 'BambooFw/Lib/Core/BaseClass.rb'
# 	require 'BambooFw/BambooFw.rb'
# 	require 'BambooServer/BambooServer.rb'
# 	require app_path + 'Apps.rb'
# 	require 'BambooFw/Lib/Utils/conv_camel_snake.rb'
# rescue Exception => e
# 	puts e.message
# end

# src = "CamlCase1ASnakeCase2B"
# puts "  SRC: #{src}"
# snake = src.to_snake
# puts "SNAKE: #{snake}"
# camel = snake.to_camel
# puts "CAMEL: #{camel}"
# src = 'country'
# p "table_name(1):" + src.to_table_name
# src = 'CamlCase1ASnakeCase2B'
# p "table_name(2):" + src.to_snake.to_table_name
# autoloader = BambooFw::Lib::Core::Autoloder.new(project_root)
# config = BambooFw::Lib::Core::Config.new(project_root)
# class_files = autoloader.get_class_files
# class_files.each do |class_file|
# 	require class_file
# end
# # require '/Users/k_sato/Project/bambooFw/Apps/Models/User.rb'
# user = User.new(config)
