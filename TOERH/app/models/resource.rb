class Resource < ActiveRecord::Base
	before_create :generate_uid

	belongs_to :licence
	belongs_to :resource_type
	belongs_to :user

	has_and_belongs_to_many :tags

	validates :name, presence: {message: 'Missing "name" parameter.'}
	validates :description, presence: {message: 'Missing "description" parameter.'}

	validates :url, presence: {message: 'Missing "url" parameter.'}
	validates_format_of :url, with: /(http|https)\:\/\/[a-zA-Z0-9\-\.]+\.[a-z]+(\/\S*)?/, message: 'URL parameter has a incorrect format'

	validates :user_id, presence: {message: 'Missing "user_id" parameter'}, numericality: {message: '"user_id" have to be of tyoe integer'}

	validates :resource_type, presence: {message: 'Missing "user_type" parameter'}

	validates :licence, presence: {message: 'Missing "licence" parameter'}

	private

	def generate_uid
	    begin
	        id = SecureRandom.hex(12)
	    end while self.class.where(:resource_id => id).exists?
	    self.resource_id = id
	end
end
