class User < ActiveRecord::Base
	has_many :resources
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

			self.save!
		else
			return false
		end
		
		return self
	end

	private

	def generate_uid
	    begin
	        id = SecureRandom.hex(12)
	    end while self.class.where(:user_id => id).exists?
	    self.user_id = id
	end
end
