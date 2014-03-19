# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(email: 'admin@admin.com', password: 'password', password_confirmation: 'password')

user = User.create([
	{firstname: 'John', surname: 'Doe', email: 'john@doe.com', password: 'password', password_confirmation: 'password'},
	{firstname: 'Jane', surname: 'Doe', email: 'jane@doe.com'}
])

licence = Licence.create([
	{licence_type: 'MIT'},
	{licence_type: 'GNU'},
	{licence_type: 'CC'}
])

resourcetype = ResourceType.create([
	{resource_type: 'Video'}, 
	{resource_type: 'Document'}, 
	{resource_type: 'Image'}, 
	{resource_type: 'Other'}
])

1.upto(78) do |i|
    resource = Resource.new
    resource.name = "Resource #{i}"
    resource.description = "This is a resource description."
    resource.url = "http://www.example.com"
    resource.licence = licence.first
    resource.resource_type = resourcetype.first
    resource.user = user.first

    resource.save!
end