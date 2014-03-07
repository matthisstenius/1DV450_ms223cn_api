class Licence < ActiveRecord::Base
	has_many :resources
	before_create :generate_uid

	validates :licence_type, presence: {message: 'Missing "licence_type" parameter.'}

	private

	def generate_uid
	    begin
	        id = SecureRandom.hex(12)
	    end while self.class.where(:licence_id => id).exists?
	    self.licence_id = id
	end
end
