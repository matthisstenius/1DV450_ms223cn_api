class ErrorsController < ApplicationController
	respond_to :json, :xml
	rescue_from Exception, :with => :handle_exception

	def catch_404
		response.status = 404
		result = {status: 404, method: request.method, message: "#{request.original_url} does not exist."}

		respond_with do |format|
			format.json {render json: result}
			format.xml {render xml: result}
		end
	end
end
