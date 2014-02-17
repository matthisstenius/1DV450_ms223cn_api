class Api::V1::LicencesController < ApplicationController
	before_action :api_access_granted
	respond_to :json, :xml
	rescue_from Exception, :with => :handle_exception

	def index
		licences = Licence.all

		data = licences.map do |licence|
			format_data(licence)
		end

		result = {
			status: 200,
			message: 'All licences',
			count: data.count,
			items: data
		}

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
				licence_link: "http://#{request.host}/api/v1/licences/#{licence.licence_id}"
			}
		}
	end
end
