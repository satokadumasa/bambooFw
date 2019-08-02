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
        param = ''
        method_type = nil
        client_host_name = ''
        length = 0
        uri = ''
        while buffer = client.gets
          puts buffer

          if buffer.include? 'Content-Length'
            @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "CASE Content-Length"])
            length = buffer.split[1].to_i
          end

          if buffer.include? 'Host'
            client_host_name = buffer.split[1].to_s
            puts "client_host_name:#{client_host_name}"
            @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "client_host_name:#{client_host_name}"])
          end
          if buffer.include? 'POST'
            @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "POST"])
            method_type = 'POST'
            uri = buffer.split[1].to_s
          end
          if buffer.include? 'GET'
            @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "GET"])
            method_type = 'GET' 
            uri = buffer.split[1].to_s
          end
          if buffer.include? 'DELETE'
            @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "DELETE"])
            method_type = 'DELETE' 
            uri = buffer.split[1].to_s
          end
          if buffer.include? 'PUT'
            method_type = 'PUT' 
            uri = buffer.split[1].to_s
          end
          if buffer == "\r\n" || buffer == "\n" || buffer == "\r"
            length.times do
              param <<  client.getc
            end
            break
          end
          if buffer.chomp.empty?
            @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "Break Loop"])
            puts "Break Loop"
            break
          end
        end

        if method_type == 'GET'
          param = uri.split('?')[1]
        end

        method_type = method_type ? method_type : 'GET'

        @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "uri[#{uri}] method_type[#{method_type}] param[#{param}]"])

        params = get_params(param, method_type) if param

        @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "params:#{params.inspect}"])

        dispatcher = Libs::Core::Dispatcher.new(@config, uri, method_type, params)
        content = dispatcher.dispatch

        client.puts "HTTP/1.0 200 OK"
        client.puts "Content-Type: text/plain"
        client.puts
        client.puts content
        client.close
      end

      def pid
        file = File.open(@pid_file, "w") # samurai.txt => ファイル名
        # p Process.getpgid().to_s
        file.puts("bamboo rils.")
        file.close
      end

      def get_params(param, method_type)
        @logger.log('debug', ['BambooServer::Lib::Server', 'get_params', "param[#{param}] method_type:#{method_type}"])
        params = []
        params = divide_param(param) if param

        @logger.log('debug', ['BambooServer::Lib::Server', 'get_params', "params:#{params.inspect}"])
        params
      end

      def divide_param(param)
        params = []
        arr = param.split('&')
        arr.each do |str|
          param_arr = str.split('=')
          params.push({param_arr[0] => param_arr[1]})
        end
        params
      end

      def check_image_extensions
        @config.app['image_extensions']
      end
    end
  end
end
