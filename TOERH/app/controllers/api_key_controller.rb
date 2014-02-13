class ApiKeyController < ApplicationController
	def index

	end

	def generate
		apiKey = SecureRandom.hex(10)
		email = params[:email]

		app = ApiKey.create(api_key: apiKey, email: email)

		if app.invalid?
			flash[:error] = app.errors[:email].first
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
