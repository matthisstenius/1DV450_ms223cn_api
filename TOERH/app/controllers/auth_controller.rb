class AuthController < ApplicationController
	def index

	end

	def login
		admin = Admin.where(:email => params[:email]).take
		if admin
			if admin.authenticate(params[:password])
				session[:admin] = admin.id
				return redirect_to admin_index_path
			end
		end

		flash[:error] = 'Wrong username or password'
		redirect_to :back
	end

	def logout
		session.delete(:admin)
		redirect_to :root
	end
end
