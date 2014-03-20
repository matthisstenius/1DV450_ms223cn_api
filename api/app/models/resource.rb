class Resource < ActiveRecord::Base
	before_create :generate_uid

	belongs_to :licence
	belongs_to :resource_type
	belongs_to :user

	has_and_belongs_to_many :tags

	validates :name, presence: {message: 'Invalid name. Must be string.'}
	validates :description, presence: {message: 'Invalid descripton. Must be string'}

	validates :url, presence: {message: 'Missing url. Must be string'}
	validates_format_of :url, with: /(http|https)\:\/\/[a-zA-Z0-9\-\.]+\.[a-z]+(\/\S*)?/, message: 'URL parameter has a incorrect format. Use http://www.example.com'

	validates :user_id, presence: {message: 'Missing user_id parameter'}

	validates :resource_type_id, presence: {message: 'Missing resource_type parameter'}

	validates :licence_id, presence: {message: 'Missing licence_type parameter'}

	def getResources(params)
		limit = params[:limit] || 25
		offset = params[:offset] || 0

		if params[:user_id]
			user = User.where(user_id: params[:user_id]).take!
			resources = Resource.limit(limit).offset(offset).order(id: :desc).where(user_id: user.id)
		elsif params[:licence_id]
			licence = Licence.where(licence_id: params[:licence_id]).take!
			resources = Resource.limit(limit).offset(offset).order(id: :desc).where(licence_id: licence.id)
		elsif params[:resourcetype_id]
			resourcetype = ResourceType.where(resource_type_id: params[:resourcetype_id]).take!
			resources = Resource.limit(limit).offset(offset).order(id: :desc).where(resource_type_id: resourcetype.id)
		elsif params[:search]
			resources = Resource.limit(limit).offset(offset).order(id: :desc).where("name like ?", "%#{params[:search]}%")
		else
			resources = Resource.limit(limit).offset(offset).order(id: :desc)
		end
	end

	def getResource(params)
		if params[:user_id]
			user = User.where(user_id: params[:user_id]).take!
			resource = Resource.where(user_id: user.id).take!
		else
			resource = Resource.where(resource_id: params[:id]).take!
		end
	end

	def add(input)
		self.name = input[:name]
		self.description = input[:description]
		self.url = input[:url]
		self.user = User.where(user_id: input[:user_id]).take!
		self.resource_type = ResourceType.where(resource_type_id: input[:resource_type_id]).take!
		self.licence = Licence.where(licence_id: input[:licence_id]).take!

		self.save!

		tags = input[:tags]

		if tags
			self.tags = []
			tags.each do |tag|
				self.tags << Tag.create(tag: tag)
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
