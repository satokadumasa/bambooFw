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
        @logger = Libs::Utils::Logger.new(@project_root)
      end

      def main_proc
      	bamboo = Libs::Core::Dispatcher.new(@config)
        server = TCPServer.new @port
        pid
        pids = []
        loop do
          Thread.start(server.accept) do |client|
            sarver client
            break unless File.exist? @pid_file
          end
        end
      end
        
      def sarver(client)
        p [Thread.current]
        headers = []
        while header = client.gets
          break if header.chomp.empty?
          headers << header.chomp
        end
        logger.log('debug', ['bamboo', 'main', "headers:#{headers.inspect}"])

        Libs::Core::Dispatcher.new(@config)
        p [Thread.current, headers]

        client.puts "HTTP/1.0 200 OK"
        client.puts "Content-Type: text/plain"
        client.puts
        client.puts "message body"
        client.close
      end

      def pid
        file = File.open(@pid_file, "w") # samurai.txt => ファイル名
        # p Process.getpgid().to_s
        file.puts("bamboo rils.")
        file.close
      end
    end
  end
end
