require 'mysql'

class Libs
	class Core
    class BaseModel < Libs::Core::BaseClass
      def initialize(config)
			  # adapter: mysql2
			  # encoding: utf8
			  # database: blog_development
			  # username: <%= ENV['BAMBOO_DB_USER'] %>
			  # password: <%= ENV['BAMBOO_DB_PASSWORD'] %>
			  # pool: 20
			  # timeout: 5000
			  @pk = 'id'
			  @table_name = self.name.to_snake
				yaml = YAML.load_file(config.project_root + "/config/app.yml")
				@databases = yaml['databases']
      	@connection = Mysql::connect(@databases["hostname"], @databases["username"], @databases["password"], @databases["dbname"])
      	@connection.query("set character set #{@databases['encoding']}")
      end
    end

    def find(id)
    	sql = "SELECT * FROM #{@class_name} AS #{@class_name}"
    	
    end
  end
end
