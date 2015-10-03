# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  user = User.create(email:"marko.borovac@fer.hr", first_name:"Marko", last_name:"Borovac", password:"12345678")
  unless user.save
    puts "Cannot save"
  end
