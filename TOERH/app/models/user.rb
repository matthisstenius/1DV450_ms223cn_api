class User < ActiveRecord::Base
	has_many :resources
	before_create :generate_uid

	validates :firstname, presence: {message: 'Missing firstname parameter.'}
	validates :surname, presence: {message: 'Missing surname parameter.'}
	validates :email, presence: {message: 'Missing email parameter.'}
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid Email"

	def add(input)
		self.firstname = input[:firstname]
		self.surname = input[:surname]
		self.email = input[:email]

		self.save!

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
