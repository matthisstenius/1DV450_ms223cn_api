class TOERH::UserAuth
	def get_authenticated_user(email, password)
		user = User.where(email: email).take!

		if user.authenticate(password)
			begin
				user.access_token = SecureRandom.hex(10)
			end while User.where(:access_token => user.access_token).exists?

			user.access_token_expire = Time.now + 300
			user.save!

			return user
		end

		raise ArgumentError
	end
end