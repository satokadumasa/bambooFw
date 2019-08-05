require 'net/http'

class Apps < BaseClass
	class Controllers < BaseClass
		class UsersController < BambooFw::Lib::Core::BaseController
			def initialize(config, params)
				super(config, params)
				@logger.log('debug',['Apps::Controllers::UsersController','initialize', "params:#{params.inspect}"])
			end

			def index
				begin
					user = Apps::Models::User.new(@config)
					users = user.find_all
					@logger.log('debug',['Apps::Controllers::UsersController','index', "users:#{users.inspect}"])
					@view_data['Users'] = users
				rescue Exception => e
					@logger.log('debug',['Apps::Controllers::UsersController','index', "Error:#{e.message}"])
				end
			end
			def show
				id = 0
				begin
					user = Apps::Models::User.new(@config)
					@logger.log('debug',['Apps::Controllers::UsersController','show', "params:#{@params.inspect}"])

					@logger.log('debug',['Apps::Controllers::UsersController','show', "id:#{@params['id']}"])
					# @logger.log('debug',['Apps::Controllers::UsersController','show', "id:#{@params[:id].inspect}"])
					user = user.find(@params['id'].to_i)
					# @users = user.find(1)
					# user = {'id' => 1, 'name' => 'name1'}
					# @users.push(user)
					@logger.log('debug',['Apps::Controllers::UsersController','show', "user:#{@user.inspect}"])
					@view_data['User'] = user
				rescue Exception => e
					@logger.log('debug',['Apps::Controllers::UsersController','show', "Error:#{e.message}"])
				end
			end

			def new
				begin
					user = Apps::Models::User.new(@config)
					if @params['method_type'] == 'POST'
						if user.save(@params)
							redirect_to('/users/')
							# exit
						end
					end
				rescue Exception => e
					@logger.log('debug',['Apps::Controllers::UsersController','new', "Error:#{e.message}"])
					redirect_to('/users/')
					# exit
				end
			end

			def redirect_to(uri)
				begin
					@view_data = "Location: #{@config.base_url}#{uri}"

				rescue Exception => e
					@logger.log('debug',['Apps::Controllers::UsersController','redirect_to', "Error:#{e.message}"])
				end
			end
		end
	end
end
