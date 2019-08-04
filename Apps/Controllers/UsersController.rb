class Apps < BaseClass
	class Controllers < BaseClass
		class UsersController < Libs::Core::BaseController
			def initialize(config, params)
				super(config, params)
				@logger.log('debug',['Apps::Controllers::UsersController','initialize', "params:#{params.inspect}"])
			end

			def index
				@data = {}
				begin
					user = Apps::Models::User.new(@config)
					@users = user.find_all
					@data['Users'] = @users
				rescue Exception => e
					@logger.log('debug',['Apps::Controllers::UsersController','index', "Error:#{e.message}"])
				end
				@data
			end
			def show
				@data = {}
				@users = []
				id = 0
				begin
					user = Apps::Models::User.new(@config)
					@logger.log('debug',['Apps::Controllers::UsersController','show', "params:#{@params.inspect}"])

					@logger.log('debug',['Apps::Controllers::UsersController','show', "id:#{@params['id']}"])
					# @logger.log('debug',['Apps::Controllers::UsersController','show', "id:#{@params[:id].inspect}"])
					@user = user.find(@params['id'].to_i)
					# @users = user.find(1)
					# user = {'id' => 1, 'name' => 'name1'}
					# @users.push(user)
					@logger.log('debug',['Apps::Controllers::UsersController','show', "user:#{@user.inspect}"])
					@data['User'] = @user
				rescue Exception => e
					@logger.log('debug',['Apps::Controllers::UsersController','show', "Error:#{e.message}"])
				end
				@data
			end
		end
	end
end
