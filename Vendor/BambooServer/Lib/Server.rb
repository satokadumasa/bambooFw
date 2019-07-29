require 'socket'
require 'fileutils'

class BambooServer
  class Lib
    class Server < Libs::Core::BaseClass
      def initialize(config)
        p "config.server:" + config.server.inspect
        @port = config.server['port'] ? config.server['port'] : 8080
        @host = config.server['host'] ? config.server['host'] : '127.0.0.1'
        @protocol = config.server['protocol'] ? config.server['protocol'] : 'http'
        @project_root = config.project_root
        @pid_file = @project_root + "/tmp/pids/bamboo.pdi"
      end

      def main
      	bamboo = Libs::Core::Bamboo.new
        server = TCPServer.new @port
        self.pid
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