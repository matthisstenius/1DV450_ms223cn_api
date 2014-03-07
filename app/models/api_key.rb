class ApiKey < ActiveRecord::Base
	validates :email, presence: {message: "Email can't be blank!"}, 
				uniqueness: {message: "Email already registered!"}

	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid Email"
end
