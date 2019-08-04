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
				  table_name = self.class.to_s.to_snake.to_table_name
	        @logger.log('debug', ['Libs::Core::BaseModel', 'initialize', "table_name:#{table_name}"])
				  @table_name = table_name.split('::').pop
	        @logger.log('debug', ['Libs::Core::BaseModel', 'initialize', "table_name:#{@table_name}"])
					database_configuration_file = config.project_root + "config/databases.yml"
					yaml = YAML::load(ERB.new(IO.read(database_configuration_file)).result)
					@databases = yaml['databases']['default']
	      	@connection = Mysql2::Client.new(host: @databases["hostname"], username: @databases["username"], password: @databases["password"], database: @databases["dbname"])
	      	@connection.query("set character set #{@databases['encoding']}")
				rescue Exception => e
	        @logger.log('debug', ['Libs::Core::BaseModel', 'initialize', "Error:#{e.message}"])
				end
      end

	    def find_all
				@logger.log('debug', ['Libs::Core::BaseModel', 'find_all', "find_all START"])
				begin
		    	data = []
		    	sql = "SELECT * FROM #{@table_name} AS #{@table_name}"
	        @logger.log('debug', ['Libs::Core::BaseModel', 'find_all', "sql:#{sql}"])
		    	rs = @connection.query(sql)
					rs.each do |r|
						data.push(r)
					end
					data
				rescue Exception => e
					@logger.log('debug', ['Libs::Core::BaseModel', 'find_all', "Error:#{e.message}"])
				end
	    end

	    def find(id)
        @logger.log('debug', ['Libs::Core::BaseModel', 'find', 'START'])
        data = nil
	    	begin
	        @logger.log('debug', ['Libs::Core::BaseModel', 'find', "id:" + id.inspect])
	        id = @connection.escape(id.to_s)
		    	sql = "SELECT #{@table_name}.* FROM #{@table_name} AS #{@table_name} WHERE id = ?"
		    	stmt = @connection.prepare(sql)
		    	rs = stmt.execute(id.to_i)
					rs.each do |r|
						data = r
						break
					end
	        data
	    	rescue Exception => e
	        @logger.log('debug', ['Libs::Core::BaseModel', 'find', "Error:#{e.message}"])
	    	end
	    end
    end
  end
end
