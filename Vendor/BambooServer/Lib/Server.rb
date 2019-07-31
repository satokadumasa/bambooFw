require 'socket'
require 'fileutils'

class BambooServer < BaseClass
  class Lib < BaseClass
    class Server < BaseClass
      def initialize(config)
        @config = config
        @port = @config.server['port'] ? @config.server['port'] : 8080
        @host = @config.server['host'] ? @config.server['host'] : '127.0.0.1'
        @protocol = @config.server['protocol'] ? @config.server['protocol'] : 'http'
        @project_root = @config.project_root
        @pid_file = @project_root + "/tmp/pids/bamboo.pdi"
        puts "pid_file[#{@pid_file}]"
        @logger = Libs::Utils::Logger.new(@project_root)
      end

      def main_proc
        @logger.log('debug', ['bamboo', 'main_proc', "Start"])
      	# bamboo = Libs::Core::Dispatcher.new(@config)
        server = TCPServer.new @port
        pid
        pids = []
        @logger.log('debug', ['bamboo', 'main_proc', "CH-01"])
        while File.exist? @pid_file do
          @logger.log('debug', ['bamboo', 'main_proc', "Thread wait"])
          Thread.start(server.accept) do |client|
            @logger.log('debug', ['bamboo', 'main_proc', "Thread.Start"])
            sarver client
          end
        end
      end
        
      def sarver(client)
        @logger.log('debug', ['bamboo', 'sarver', "Start"])
        p [Thread.current]
        buffers = []
        buffers2 = []
        method_type = nil
        client_host_name = ''
        lenght = 0
        uri = '/'
        while buffer = client.gets
          puts buffer
          buffers2 << buffer
          @logger.log('debug', ['bamboo', 'sarver', "buffer:#{buffer}"])
          break if buffer.chomp.empty?

          if buffer.include? 'Content-Length'
            lenght = buffer.split[1].to_i
          end

          if buffer.include? 'Host'
            client_host_name = buffer.split[1].to_s
            puts "client_host_name:#{client_host_name}"
            @logger.log('debug', ['Server', 'sarver', "client_host_name:#{client_host_name}"])
          end
          if buffer.include? 'POST'
            @logger.log('debug', ['Server', 'sarver', "POST"])
            method_type = 'POST'
            uri = buffer.split[1].to_s
          end
          if buffer.include? 'GET'
            @logger.log('debug', ['Server', 'sarver', "GET"])
            method_type = 'GET' 
            uri = buffer.split[1].to_s
          end
          if buffer.include? 'DELETE'
            @logger.log('debug', ['Server', 'sarver', "DELETE"])
            method_type = 'DELETE' 
            uri = buffer.split[1].to_s
          end
          if buffer.include? 'PUT'
            method_type = 'PUT' 
            uri = buffer.split[1].to_s
          end
          method_type = method_type ? method_type : 'GET'
          if method_type == 'POST' && (buffer == "\r\n" || buffer == "\n" || buffer == "\r")
            if lenght > 0
              lenght.times do
                buffers << client.gets
              end
            end
          end
          # buffers << client.gets
        end
        puts buffers2
        @logger.log('debug', ['bamboo', 'sarver', "buffers:#{buffers.inspect}"])
        @logger.log('debug', ['bamboo', 'sarver', "config:#{@config.inspect}"])
        @logger.log('debug', ['bamboo', 'sarver', "uri:#{uri}"])
        @logger.log('debug', ['bamboo', 'sarver', "method_type:#{method_type}"])

        params = get_params(uri, buffers, method_type)

        @logger.log('debug', ['Server', 'sarver', "params:#{params.inspect}"])

        dispatcher = Libs::Core::Dispatcher.new(@config, params, uri, method_type)
        content = dispatcher.dispatch

        puts "CH-00001"
        client.puts "HTTP/1.0 200 OK"
        puts "CH-00002"
        client.puts "Content-Type: text/plain"
        puts "CH-00003"
        client.puts
        puts "CH-00004"
        client.puts content
        puts "CH-00005"
        client.close
      end

      def pid
        file = File.open(@pid_file, "w") # samurai.txt => ファイル名
        # p Process.getpgid().to_s
        file.puts("bamboo rils.")
        file.close
      end

      def get_params(uri, buffers, method_type)
        @logger.log('debug', ['Server', 'get_params', "uri[#{uri}] method_type:#{method_type}"])
        params = []
        if method_type == 'GET'
          puts "get_params CASE GET"
          uri = uri.split('?')[1]
          puts "get_params CASE GET(2) uri:#{uri}"
          arr = uri.split('&')
          puts "get_params CASE GET(3) arr:#{arr.inspect}"
          arr.each do |param|
            puts "param:#{param}"
            param_arr = param.split('=')
            puts "param_arr:#{param_arr}"
            params.push({param_arr[0] => param_arr[1]})
          end
          if method_type == 'POST'
            buffers.each do |buffer|
            end
          end

          @logger.log('debug', ['Server', 'get_params', "params:#{params.inspect}"])
          params
        end
      end

      def check_image_extensions
        @config.app['image_extensions']
      end
    end
  end
end
