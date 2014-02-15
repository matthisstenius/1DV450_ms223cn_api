class Tag < ActiveRecord::Base
	has_and_belongs_to_many :resources
	before_create :generate_uid

	private

	def generate_uid
	    begin
	        id = SecureRandom.hex(12)
	    end while self.class.where(:tag_id => id).exists?
	    self.tag_id = id
	end
end