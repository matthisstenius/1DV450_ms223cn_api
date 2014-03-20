class Api::V1::ResourcesController < ApplicationController
	before_action :api_access_granted
	before_action :authorize, only: [:destroy, :update, :create]
	before_action :check_params, only: [:create, :update]
	respond_to :json, :xml
	rescue_from Exception, :with => :handle_exception

	def index
		limit = params[:limit] || 25
		offset = params[:offset] || 0

		resources = Resource.new.getResources(params)

		if resources.count > 0
			data = resources.map do |resource|
				format_data(resource)
			end

			result = {
				status: 200,
				message: 'All resources',
				count: resources.count,
			 	items: data,
			 	pagination: {
			 		prev_url: "http://#{request.host}/api/v1/resources?limit=#{limit}&offset=#{offset}",
			 		next_url: "http://#{request.host}/api/v1/resources.json?limit=#{limit}&offset=#{offset = offset.to_i + limit.to_i}"
			 	}
			}

			if params[:user_id]
				result[:pagination][:prev_url] = "http://#{request.host}/api/v1/users/#{params[:user_id]}/resources?limit=#{limit}&offset=#{offset}"
				result[:pagination][:next_url] = "http://#{request.host}/api/v1/users/#{params[:user_id]}/resources?limit=#{limit}&offset=#{offset = offset.to_i + limit.to_i}"
			end
		
		else
			response.status = 200
			result = {status: 200, message: 'No resourses could be found'}
		end

		respond_with result
	end

	def show
		resource = Resource.new.getResource(params)
		
		data = format_data(resource)

		result = {status: 200, message: 'Resource #{resourse.name}', items: data}
	
		respond_with result
	end	

	def create
		resource = Resource.new.add(params)

		data = format_data(resource)

		response.status = 201

		result = {status: 201, message: 'Created resource successfully', items: data}

		respond_with result, location: nil
	end

	def update
		resource = Resource.where(resource_id: params[:id]).take!
		resource.add(params)
	
		data = format_data(resource)

		response.status = 201
		result = {status: 201, message: 'Updated resource successfully', items: data}
		
		respond_with do |format|
			format.json {render json: result}
			format.xml {render xml: result}
		end
	end

	def destroy
		resource = Resource.where(resource_id: params[:id]).take!

		resource.destroy

		data = {status: 200, message: 'Successfully removed resource'}

		respond_with do |format|
			format.json {render json: data}
			format.xml {render xml: data}
		end
	end

	def search

	end
	private

	def format_data(resource)
		data = {
			data: {
				id: resource.resource_id,
				name: resource.name,
				description: resource.description,
				url: resource.url,
				created_at: resource.created_at,
				updated_at: resource.updated_at,
			},
			user: {
				id: resource.user.user_id,
				firstname: resource.user.firstname,
				surname: resource.user.surname,
				email: resource.user.email,
				created_at: resource.user.created_at,
				updated_at: resource.user.updated_at,
			},

			licence: {
				id: resource.licence.licence_id,
				licence: resource.licence.licence_type,
			},

			resource_type: {
				id: resource.resource_type.resource_type_id,
				resource_type: resource.resource_type.resource_type,
			},

			tags: resource.tags,

			links: {
				resource_link: "http://#{request.host}/api/v1/resources/#{resource.resource_id}"
			}
		}

	end

	def check_params
		errors = {}

		if params[:name].nil?
			errors[:name] = ["Missing name parameter"]
		end

		if params[:description].nil?
			errors[:description] = ["Missing description parameter"]
		end

		if params[:url].nil?
			errors[:url] = ["Missing url parameter"]
		end

		if params[:resource_type_id].nil?
			errors[:resource_type_id] = ["Missing resource_type_id parameter"]
		end

		if params[:licence_id].nil?
			errors[:licence_id] = ["Missing licence_id parameter"]
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
