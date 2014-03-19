class Api::V1::UsersController < ApplicationController
	before_action :api_access_granted
	before_action :authorize, only: [:destroy, :update]
	before_action :check_params, only: [:create, :update]
	respond_to :json, :xml
	rescue_from Exception, :with => :handle_exception

	def index
		limit = params[:limit] || 25
		offset = params[:offset] || 0

		users = User.limit(limit).offset(offset).order(id: :desc)

		if users.count > 0
			data = users.map do |user|
				format_data(user)
			end

			if users.count < limit.to_i
				result = {
					status: 200,
					message: 'All users',
					count: users.count,
					items: data,
					pagination: {
				 		prev_link: "http://#{request.host}/api/v1/users?limit=#{limit}&offset=#{offset}"
				 	}
				}
			else 	
				result = {
					status: 200,
					message: 'All users',
					count: users.count,
					items: data,
					pagination: {
				 		prev_link: "http://#{request.host}/api/v1/users?limit=#{limit}&offset=#{offset}",
				 		next_link: "http://#{request.host}/api/v1/users?limit=#{limit}&offset=#{offset = offset.to_i + limit.to_i}"
				 	}
				}
			end
		else
			response.status = 200
			result = {status: 200, message: 'No users could be found'}
		end

		respond_with result
	end

	def show
		user = User.where(user_id: params[:id]).take!

		data = format_data(user)

		result = {
			status: 200,
			message: "Showing user with id #{user.user_id}",
			items: data
		}

		respond_with result
	end

	def create
		user = User.new.add(params)

		if user
			data = format_data(user)

			data[:data][:access_token] = user.access_token

			status = 201

			result = {status: 201, message: 'Created user successfully', items: data}
		else
			status = 400
			
			result = {status: 400, message: "An user already exist with email: #{params[:email]}"}
		end

		respond_with result, location: nil, status: status
	end

	def update
		user = User.where(user_id: params[:id]).take!
		
		user.update(user, params)
		data = format_data(user)

		response.status = 201
		result = {status: 201, message: "Updated user with ID: #{user.user_id} successfully", items: data}
			
		respond_with do |format|
			format.json {render json: result}
			format.xml {render xml: result}
		end
	end

	def destroy
		user = User.where(user_id: params[:id]).take!
		user.destroy

		data = {status: 200, message: 'Successfully removed user'}

		respond_with do |format|
			format.json {render json: data}
			format.xml {render xml: data}
		end
	end

	private

	def format_data(user)
		data = {
			data: {
				user_id: user.user_id,
				firstname: user.firstname,
				surname: user.surname,
				email: user.email
			},
			links: {
				user_url: "http://#{request.host}/api/v1/users/#{user.user_id}"
			}
		}
	end

	def check_params
		errors = {}

		if params[:firstname].nil?
			errors[:firstname] = ["Missing firstname parameter"]
		end

		if params[:surname].nil?
			errors[:surname] = ["Missing surname parameter"]
		end

		if params[:email].nil?
			errors[:email] = ["Missing email parameter"]
		end

		if params[:password].nil?
			errors[:password] = ["Missing password parameter"]
		end

		unless errors.empty?
			response.status = 400

			errorResponse =  {status: 400, message: "Faulty parameters detected", errors: errors}
			respond_to do |format|
		      format.xml { render xml: errorResponse}
		      format.json {render json: errorResponse}
		    end
		end
	end
end
