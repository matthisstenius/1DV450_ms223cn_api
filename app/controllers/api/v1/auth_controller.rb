require "#{Rails.root}/app/TOERH/UserAuth"

class Api::V1::AuthController < ApplicationController
	before_action :api_access_granted
	respond_to :json, :xml
	#rescue_from Exception, :with => :handle_exception

	def authenticate
		userAuth = TOERH::UserAuth.new

		begin
			access_token = userAuth.get_access_token(params[:email], params[:password])

			result = {
				status: 200,
				message: 'Here is your access_token',
				access_token: access_token,
			}
		rescue Exception
			response.status = 400
			
			result = {
				status: '400',
				message: 'An access_token could not be generated. Check that the credentials are correct'
			}
		end

		respond_with result, location: nil
	end
end
