class ApiKey < ActiveRecord::Base
	validates :email, presence: true
end
