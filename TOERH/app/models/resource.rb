class Resource < ActiveRecord::Base
	belongs_to :licence
	belongs_to :resource_type
	belongs_to :user

	has_and_belongs_to_many :tags

	validates :name, presence: {message: 'Missing "name" parameter.'}
	validates :description, presence: {message: 'Missing "description" parameter.'}

	validates :user_id, presence: {message: 'Missing "user_id" parameter'}, numericality: {message: '"user_id" have to be of tyoe integer'}

	validates :resource_type_id, presence: {message: 'Missing "userType_id" parameter'}, numericality: {message: '"resourceType_id" have to be of tyoe integer'}

	validates :licence_id, presence: {message: 'Missing "licence_id" parameter'}, numericality: {message: '"licence_id" have to be of tyoe integer'}

end
