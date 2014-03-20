class Api::V1::ResourcetypesController < ApplicationController
	before_action :api_access_granted
	respond_to :json, :xml
	rescue_from Exception, :with => :handle_exception

	def index
		limit = params[:limit] || 25
		offset = params[:offset] || 0

		resourceTypes = ResourceType.limit(limit).offset(offset).order(id: :desc)

		if resourceTypes.count > 0
			data = resourceTypes.map do |resourceType|
				format_data(resourceType)
			end

			if resourceTypes.count < limit.to_i
				result = {
					status: 200,
					message: 'All users',
					count: resourceTypes.count,
					items: data,
					pagination: {
				 		prev_url: "http://#{request.host}/api/v1/resourcetypes?limit=#{limit}&offset=#{offset}",
				 	}
				}
			else 	
				result = {
					status: 200,
					message: 'All users',
					count: resourceTypes.count,
					items: data,
					pagination: {
				 		prev_url: "http://#{request.host}/api/v1/resourcetypes?limit=#{limit}&offset=#{offset}",
				 		next_url: "http://#{request.host}/api/v1/resourcetypes?limit=#{limit}&offset=#{offset = offset.to_i + limit.to_i}"
				 	}
				}
			end
		else
			response.status = 200
			result = {status: 200, message: 'No licencetypes could be found'}
		end

		respond_with result
	end

	def show
		resourceType = ResourceType.where(resource_type_id: params[:id]).take!

		data = format_data(resourceType)

		result = {
			status: 200,
			message: "Showing resourcetype with ID: #{resourceType.resource_type_id}",
			items: data
		}

		respond_with result
	end

	private

	def format_data(resourceType)
		data = {
			data: {
				id: resourceType.resource_type_id,
				resource_type: resourceType.resource_type
			},
			links: {
				resourcetype_url: "http://#{request.host}/api/v1/resourcetypes/#{resourceType.resource_type_id}"
			}
		}
	end
end
