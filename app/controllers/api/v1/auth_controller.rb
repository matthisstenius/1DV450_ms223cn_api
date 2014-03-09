require "#{Rails.root}/app/TOERH/UserAuth"

class Api::V1::AuthController < ApplicationController
	#before_action :api_access_granted
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

	def check_access_token
		access_token = params[:access_token]

		user = User.where(access_token: access_token).take

		unless user
	    	response.status = 401

		    errorResponse = {
		      status: 401, 
		      message: "Unauthorized request.", 
		      links: {
		        authenticate: "http://#{request.host}/api/v1/authenticate",
		        documentation: "http://#{request.host}/docs?autehnticate"
		      }
		    }
	    else
	    	if user.access_token_expire < Time.now
	      		response.status = 401

			    errorResponse = {
			      status: 401, 
			      message: "The access_token has expired", 
			      links: {
			        authenticate: "http://#{request.host}/api/v1/authenticate",
			        documentation: "http://#{request.host}/docs?autehnticate"
			      }
			    }
	      end
	    end

	    respond_with errorResponse, location: nil
	end
end
