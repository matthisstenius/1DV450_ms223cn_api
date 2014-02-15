class ResourceType < ActiveRecord::Base
	has_many :resources
	before_create :generate_uid

	validates :resource_type, presence: {message: 'Missing "resource_type" parameter.'}
	private

	def generate_uid
	    begin
	        id = SecureRandom.hex(12)
	    end while self.class.where(:resource_type_id => id).exists?
	    self.resource_type_id = id
	end
end
