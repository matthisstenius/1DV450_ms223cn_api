require "#{Rails.root}/app/TOERH/UserAuth"

class Api::V1::AuthController < ApplicationController
	before_action :api_access_granted
	respond_to :json, :xml
	rescue_from Exception, :with => :handle_exception

	def authenticate
		userAuth = TOERH::UserAuth.new

		begin
			user = userAuth.get_authenticated_user(params[:email], params[:password])

			status = 200

			result = {
				status: 200,
				message: 'Authentication successful',
				access_token: user.access_token,
				user: {
					user_id: user.user_id,
					firstname: user.firstname,
					surname: user.surname,
					email: user.email,
				}
			}
		rescue Exception
			status = 400
			
			result = {
				status: '400',
				message: 'An access_token could not be generated. Check that the credentials are correct'
			}
		end

		respond_with result, location: nil, status: status
    end
end
