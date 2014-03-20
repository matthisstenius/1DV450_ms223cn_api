class Api::V1::LicencesController < ApplicationController
	before_action :api_access_granted
	respond_to :json, :xml
	rescue_from Exception, :with => :handle_exception

	def index
		limit = params[:limit] || 25
		offset = params[:offset] || 0

		licences = Licence.limit(limit).offset(offset).order(id: :desc)

		if licences.count > 0
			data = licences.map do |licence|
				format_data(licence)
			end

			if licences.count < limit.to_i
				result = {
					status: 200,
					message: 'All licences',
					count: data.count,
					items: data,
					pagination: {
						prev_url: "http://#{request.host}/api/v1/licences?limit=#{limit}&offset=#{offset}"
				}	}
			else 	
				result = {
					status: 200,
					message: 'All licences',
					count: data.count,
					items: data,
					pagination: {
						prev_url: "http://#{request.host}/api/v1/licences?limit=#{limit}&offset=#{offset}",
				 		next_url: "http://#{request.host}/api/v1/licences?limit=#{limit}&offset=#{offset = offset.to_i + limit.to_i}"
					}
				}
			end
		else
			response.status = 200
			result = {status: 200, message: 'No licences could be found'}
		end

		respond_with result
	end

	def show
		licence = Licence.where(licence_id: params[:id]).take!

		data = format_data(licence)

		result = {
			status: 200,
			message: "Showing licence with ID: #{licence.licence_id}",
			items: data
		}

		respond_with result
	end

	private 

	def format_data(licence)
		data = {
			data: {
				id: licence.licence_id,
				licence_type: licence.licence_type
			},

			links: {
				licence_url: "http://#{request.host}/api/v1/licences/#{licence.licence_id}"
			}
		}
	end
end
