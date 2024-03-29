require 'socket'
require 'fileutils'

require 'kconv'
# require 'cgi'
# require 'cgi/session'
require 'securerandom'
require 'net/http'

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
        @logger = BambooFw::Lib::Utils::Logger.new(@project_root)
      end

      def main_proc
        server = TCPServer.new @port
        pid
        pids = []
        while File.exist? @pid_file do
          Thread.start(server.accept) do |client|
            sarver client
          end
        end
      end
        
      def sarver(client)
        begin

          @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "Start"])
          ARGV.replace(["session_key"=>"001"])
          @cookie = CGI::Cookie.new({"name" => "JSESSIONID" ,"path"=>"xxxx"})
          @cgi = CGI.new('html4')
          @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "cgi:#{@cgi.inspect}"])
          # @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "session_key[#{session_key.inspect}]"])
          File.umask(0077)                                # セッションファイルは誰にも読まれたくないよ
          @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "CH-01"])
          @session = CGI::Session.new(@cgi)               # セッションはこうして生成する。
          @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "CH-02"])
          @session.delete_sessiom
          @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "CH-03"])
          @session['session_key'] = SecureRandom.random_bytes(10) unless @session
          # @cmd = "#{@cgi['cmd'].first}"                   # ruby 1.8 でも動くように(warning は出ます)
          # @cmd = 'start' if @cmd.empty?
          # @header = { "type" => "text/html", "charset" => "uft-8" }
          @header = { "type" => "text/html" }
        rescue Exception => e
          @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "Exception Error:#{e.message}" ])
          
        end
        # @cmd = "#{@cgi['cmd'].first}"                   # ruby 1.8 でも動くように(warning は出ます)
        # @cmd = 'start' if @cmd.empty?
        # # @header = { "type" => "text/html", "charset" => "uft-8" }

        # __send__("cmd_#{@cmd}")


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
            str = uri.split('?')[0]
            # @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "str:#{str}"])
            id = str.split('/').pop
            # @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "id:#{id.inspect}"])
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

        params = get_params(param, method_type, id) 

        dispatcher = BambooFw::Lib::Core::Dispatcher.new(@config, uri, method_type, params)
        content = dispatcher.dispatch

        # @logger.log('debug', ['BambooServer::Lib::Server', 'sarver', "content:#{content}"])
        if content.include?('Location: ')
          client.puts "HTTP/1.1 302 Found"
          client.puts content
          client.puts
          client.close
          return
        end
        cookie = CGI::Cookie::new({"name" => "name", "value" => "value"})
        # content = @cgi.out(@header) {content}
        # puts "--------"
        # puts "content:#{content}"
        client.puts "HTTP/1.0 200 OK"
        client.puts "Content-Type: text/html"
        client.puts "Set-Cookie: #{@cookie.to_s}"
        client.puts
        client.puts content
        # client.puts content
        client.close
      end

      def pid
        file = File.open(@pid_file, "w") # samurai.txt => ファイル名
        # p Process.getpgid().to_s
        file.puts("bamboo rils.")
        file.close
      end

      def get_params(param, method_type, id)
        @logger.log('debug', ['BambooServer::Lib::Server', 'get_params', "id:#{id}"])
        params = {}
        params = divide_param(param) if param
        params['id'] = id if id
        # @logger.log('debug', ['BambooServer::Lib::Server', 'get_params', "params[#{params.inspect}]"])

        params
      end

      def divide_param(param)
        # @logger.log('debug', ['BambooServer::Lib::Server', 'divide_param', "id[#{param.inspect}]"])
        params = {}
        arr = param.split('&')
        arr.each do |str|
          param_arr = str.split('=')
          params[param_arr[0]] = param_arr[1]
        end
        params
      end

      def check_image_extensions
        @config.app['image_extensions']
      end
    end
  end
end
