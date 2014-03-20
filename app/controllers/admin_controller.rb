class AdminController < ApplicationController
	before_action :require_login
	
	def index
		@apiKeys = ApiKey.all
	end

	def destroy
		apiKey = ApiKey.where(:id => params[:id]).take!
		apiKey.destroy
		redirect_to '/admin'
	end
end
