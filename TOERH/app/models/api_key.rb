class ApiKey < ActiveRecord::Base
	validates :email, presence: {message: "Email can't be blank!"}, uniqueness: {message: "Email already registered!"}
end
