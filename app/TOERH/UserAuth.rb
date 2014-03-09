class TOERH::UserAuth
	def get_access_token(email, password)
		user = User.where(email: email).take!

		if user.authenticate(password)
			begin
				user.access_token = SecureRandom.hex(10)
			end while User.where(:access_token => user.access_token).exists?

			user.access_token_expire = Time.now + 300
			user.save!

			return user.access_token
		end

		raise ArgumentError
	end
end