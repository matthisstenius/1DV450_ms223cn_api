class User < ActiveRecord::Base
	has_many :resources
	before_create :generate_uid

	private

	def generate_uid
	    begin
	        id = SecureRandom.hex(12)
	    end while self.class.where(:user_id => id).exists?
	    self.user_id = id
	end
end
