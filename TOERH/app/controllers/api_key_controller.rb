class ApiKeyController < ApplicationController
	def index

	end

	def generate
		apiKey = SecureRandom.hex(10)
		email = params[:email]

		apiKey = ApiKey.create(apiKey: apiKey, email: email)

		if apiKey.invalid?
			flash[:error] = apiKey.errors[:email].first
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
