class Resource < ActiveRecord::Base
	before_create :generate_uid

	belongs_to :licence
	belongs_to :resource_type
	belongs_to :user

	has_and_belongs_to_many :tags

	validates :name, presence: {message: 'Missing name parameter.'}
	validates :description, presence: {message: 'Missing description parameter.'}

	validates :url, presence: {message: 'Missing url parameter.'}
	validates_format_of :url, with: /(http|https)\:\/\/[a-zA-Z0-9\-\.]+\.[a-z]+(\/\S*)?/, message: 'URL parameter has a incorrect format'

	validates :user_id, presence: {message: 'Missing user_id parameter'}, numericality: {message: 'user_id have to be of type integer'}

	validates :resource_type_id, presence: {message: 'Missing resource_type parameter'}

	validates :licence_id, presence: {message: 'Missing licence_type parameter'}

	#validates_associated :licence, :resource_type, :user, {message: "Missing or invalid parameter"}

	def add(input)
		self.name = input[:name]
		self.description = input[:description]
		self.url = input[:url]
		self.user = User.where(user_id: input[:user_id]).take
		self.resource_type = ResourceType.where(resource_type: input[:resource_type]).first_or_create
		self.licence = Licence.where(licence_type: input[:licence_type]).first_or_create

		self.save!

		tags = input[:tags]

		if tags
			tags = tags.split(',')

			tags.each do |tag|
				resource.tags << Tag.create(tag: tag)
			end
		end

		return self
	end

	private

	def generate_uid
	    begin
	        id = SecureRandom.hex(12)
	    end while self.class.where(:resource_id => id).exists?
	    self.resource_id = id
	end
end
