require "#{Rails.root}/app/TOERH/UserAuth"

class User < ActiveRecord::Base
	has_secure_password

	has_many :resources, :dependent => :delete_all
	before_create :generate_uid

	validates :firstname, presence: {message: 'Invalid firstname. Must be string.'}
	validates :surname, presence: {message: 'Invalid surname. Must be string.'}
	validates :email, presence: {message: 'Invalid email. Must be string.'}
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid Email."

	def add(input)
		unless User.exists?(email: input[:email])
			self.firstname = input[:firstname]
			self.surname = input[:surname]
			self.email = input[:email]
			self.password = input[:password]
			self.password_confirmation = input[:password_confirmation]

			begin
				self.access_token = SecureRandom.hex(10)
			end while self.class.where(:access_token => self.access_token).exists?

			self.access_token_expire = Time.now + 172800 ## 48 hours

			self.save!
		else
			return false
		end
		
		return self
	end

	def update(user, input)

		user.firstname = input[:firstname]
		user.surname = input[:surname]
		user.email = input[:email]
		user.password = input[:password]
		user.password_confirmation = input[:password_confirmation]

		user.save!

		return user
	end

	private

	def generate_uid
	    begin
	        id = SecureRandom.hex(12)
	    end while self.class.where(:user_id => id).exists?
	    self.user_id = id
	end
end
