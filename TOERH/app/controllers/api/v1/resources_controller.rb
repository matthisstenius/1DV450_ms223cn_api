class Api::V1::ResourcesController < ApplicationController
	before_action :api_access_granted
	respond_to :json, :xml
	#rescue_from Exception, :with => :handle_exception

	def index
		resources = Resource.all

		if resources
			data = resources.map do |resource|
				{
					data: {
						name: resource.name,
						description: resource.description,
						url: resource.url,
						created_at: resource.created_at,
						updated_at: resource.updated_at,
					},
					user: resource.user,
					licence: resource.licence,
					resource_type: resource.resource_type,
					tags: resource.tags
				}
			end

			result = {status: 200, message: 'All resources', items: data}
		else
			result = {status: 404, message: 'No resourses could be found'}
		end

		respond_with result
	end

	def show
		resource = Resource.find(params[:id])

		data = {
			data: {
					name: resource.name,
					description: resource.description,
					url: resource.url,
					created_at: resource.created_at,
					updated_at: resource.updated_at,
				},
				user: resource.user,
				licence: resource.licence,
				resource_type: resource.resource_type,
				tags: resource.tags
		}

		result = {status: 200, message: 'Resource #{resourse.name}', items: data}
	
		respond_with result
	end	

	def create
		puts params[:tags].to_s.split(',')

		resource = Resource.create(
			name: params[:name], 
			url: params[:url], 
			description: params[:description], 
			user_id: params[:user_id],
			resource_type_id: params[:resource_type_id], 
			licence_id: params[:licence_id])


		if resource.valid?
			tags = params[:tags]

			if tags
				tags.split(',')
				tags.each do |tag|
					resource.tags << Tag.create(tag: tag)
				end
			end

			data = {
				data: {
						name: resource.name,
						description: resource.description,
						url: resource.url,
						created_at: resource.created_at,
						updated_at: resource.updated_at,
					},
					user: resource.user,
					licence: resource.licence,
					resource_type: resource.resource_type,
					tags: resource.tags
			}

			response.status = 201

			result = {status: 201, message: 'Created resource successfully', items: data}
		else
			response.status = 400

			result = {status: 400, message: 'There are errors in the request. Please correct the errors and try again', 
				errors: resource.errors}
		end

		respond_with result, location: nil
	end

	private

	def resource_params
		params.require(params).permit(:name, :description, :user_id, :resource_type_id, :licence_id)
	end
end
