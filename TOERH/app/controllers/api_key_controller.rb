class ApiKeyController < ApplicationController
	def index

	end

	def generate
		apiKey = SecureRandom.hex(10)
		email = params[:email]

		if ApiKey.where(:email => email).present?
			flash[:error] = "This email has already been registerd"
			return redirect_to :back
		end

		apiKey = ApiKey.create(apiKey: apiKey, email: email)

		if apiKey.invalid?
			flash[:error] = "Email can't be blank"
			return redirect_to :back
		end
		
		flash[:apiKey] = apiKey
		redirect_to :root
	end

	private

	def apiKey_params
		params.require(:email).permit(:email)
	end

end
