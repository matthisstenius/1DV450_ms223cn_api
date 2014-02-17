class Api::V1::UsersController < ApplicationController
	before_action :api_access_granted
	respond_to :json, :xml
	rescue_from Exception, :with => :handle_exception

	def index
		limit = params[:limit] || 25
		offset = params[:offset] || 0

		users = User.limit(limit).offset(offset).order(id: :desc)

		data = users.map do |user|
			format_data(user)
		end

		result = {
			status: 200,
			message: 'All users',
			count: users.count,
			items: data,
			rels: {
		 		prev_link: "http://#{request.host}/api/v1/users?limit=#{limit}&offset=#{offset}",
		 		next_link: "http://#{request.host}/api/v1/users?limit=#{limit}&offset=#{offset = offset.to_i + limit.to_i}"
		 	}
		}

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

		data = format_data(user)

		response.status = 201

		result = {status: 201, message: 'Created user successfully', items: data}

		respond_with result, location: nil
	end

	def update
		user = User.where(user_id: params[:id]).take!
		user.add(params)

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
				user_link: "http://#{request.host}/api/v1/users/#{user.user_id}"
			}
		}
	end

end
