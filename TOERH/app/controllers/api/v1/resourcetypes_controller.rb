class Api::V1::ResourcetypesController < ApplicationController
	before_action :api_access_granted
	respond_to :json, :xml
	rescue_from Exception, :with => :handle_exception

	def index
		limit = params[:limit] || 25
		offset = params[:offset] || 0

		resourceTypes = ResourceType.limit(limit).offset(offset).order(id: :desc)

		data = resourceTypes.map do |resourceType|
			format_data(resourceType)
		end

		result = {
			status: 200,
			message: 'All users',
			count: resourceTypes.count,
			items: data,
			rels: {
		 		prev_link: "http://#{request.host}/api/v1/resourcetypes?limit=#{limit}&offset=#{offset}",
		 		next_link: "http://#{request.host}/api/v1/resourcetypes?limit=#{limit}&offset=#{offset = offset.to_i + limit.to_i}"
		 	}
		}

		respond_with result
	end

	private

	def format_data(resourceType)
		data = {
			data: {
				user_id: resourceType.resource_type_id,
				resource_type: resourceType.resource_type
			},
			links: {
				resourcetype_link: "http://#{request.host}/api/v1/resourcetypes/#{resourceType.resource_type_id}"
			}
		}
	end
end
