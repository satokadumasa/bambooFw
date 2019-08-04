require 'mysql2'
require 'mysql2/em'
require 'erb'

class Libs < BaseClass
	class Core < BaseClass
    class BaseModel < BaseClass
      def initialize(config)
				super(config)
			  # adapter: mysql2
			  # encoding: utf8
			  # database: blog_development
			  # username: <%= ENV['BAMBOO_DB_USER'] %>
			  # password: <%= ENV['BAMBOO_DB_PASSWORD'] %>
			  # pool: 20
			  # timeout: 5000
				begin
				  @pk = 'id'
				  @table_name = self.class.to_s.to_snake.to_table_name
					# yaml = YAML.load_file(config.project_root + "config/databases.yml")
					database_configuration_file = config.project_root + "config/databases.yml"
					yaml = YAML::load(ERB.new(IO.read(database_configuration_file)).result)
					@databases = yaml['databases']['default']
	        @logger.log('debug', ['Libs::Core::BaseModel', 'initialize', "databases:#{@databases.inspect}"])
	      	# @connection = Mysql2::connect(@databases["hostname"], @databases["username"], @databases["password"], @databases["dbname"])
	      	@connection = Mysql2::Client.new(host: @databases["hostname"], username: @databases["username"], password: @databases["password"], database: @databases["dbname"])
	      	@connection.query("set character set #{@databases['encoding']}")
				rescue Exception => e
	        @logger.log('debug', ['Libs::Core::BaseModel', 'initialize', "Error:#{e.message}"])
				end
      end
    end

    def find(id)
    	sql = "SELECT * FROM #{@class_name} AS #{@class_name}"
    	
    end

    def find_all
			begin
	    	data = []
	    	sql = "SELECT * FROM #{@class_name} AS #{@class_name}"
	    	rs = @connection.query(sql)
				rs.each do |r|
					data.push(r)
				end
				data
			rescue Exception => e
				@logger.log('debug', ['Libs::Core::BaseModel', 'all', "Error:#{e.message}"])
			end
    end
  end
end
