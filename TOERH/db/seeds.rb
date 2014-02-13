# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(email: 'matthis@me.com', password: 'password', password_confirmation: 'password')

user = User.create(firstname: 'Matthis', surname: 'Stenius', email: 'matthis@me.com')
licence = Licence.create(licence_type: 'MIT')
resourceType = ResourceType.create(resource_type: 'Video')
tags = Tag.create([{tag: 'tag1'}, {tag: 'tag2'}, {tag: 'tag3'}])

resource = Resource.new

resource.name = 'Min resurs'
resource.description = 'min beskrivning'
resource.url = 'hej.com'
resource.user = user
resource.licence = licence
resource.resource_type = resourceType
resource.tags << tags

resource.save