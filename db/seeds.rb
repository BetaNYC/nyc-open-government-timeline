# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'date'

params = {

}

events = Event.create([{
                        name: "FOIA", 
                        description: "Freeodom of Information Act", 
                        category: "Law",
                        date: DateTime.now, 
                        url: "foobar.com", 
                        status: "Passed"
                          }, 
                        {
                        name: "Foobar", 
                        description: "Somasdjfsdhf", 
                        category: "Foo",
                        date: DateTime.now, 
                        url: "foobar.com", 
                        status: "Not Passed"
                          }, 
                        {
                        name: "Another law thing", 
                        description: "Lawdy law", 
                        category: "Law",
                        date: DateTime.now, 
                        url: "law.com", 
                        status: "Passed"
                          }])



events.each_with_index do |event, i|
    event.comments.build({
                          author: "Test User #{i}", 
                          content: "Foo #{i}"
                            })
    event.save
end
