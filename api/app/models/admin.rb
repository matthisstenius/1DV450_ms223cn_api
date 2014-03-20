class Admin < ActiveRecord::Base
	has_secure_password

	validates :email, presence: {message: "You have to enter a username."}, uniqueness: {message: 'The email is taken.'}

	validates :password, presence: {message: "You have to enter a password."}
end