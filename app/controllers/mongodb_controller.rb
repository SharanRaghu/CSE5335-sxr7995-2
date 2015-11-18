# Referance : http://stackoverflow.com/questions/16765864/extract-json-values-from-remote-api-with-ruby
#http://zetcode.com/db/sqliteruby/connect/
require 'json'
require 'open-uri'
require 'rubygems'
require 'mongo'

include Mongo

i = 0
count = 0

database = Mongo::Client.new([ 'ds055584.mongolab.com:55584' ], :database => 'heroku_qwfkrl8f', :user => 'sharan', :password => 'sharan')
puts '-------------------------------------------------------------------------------------------------------------------------'
while i < 1  do
	#DATA SOURCE: http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=editors&api_key=4d7847876fa96f67f881aaf1b73e0e30&format=json 
    data = JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=editors&api_key=4d7847876fa96f67f881aaf1b73e0e30&format=json").read)
      
      # iterate through the Array of returned artists and print their names                                                                                 
        data["similarartists"]["artist"].each do |artist|
        
        insertintable = database[:heroku_qwfkrl8f].insert_one({ID: count.to_s, Title: artist["name"]})
        
        count = count + 1;
      end

    i = i + 1;
end
puts '****************************************************************************************************************'

puts "Total Data Entries = #{count}"

puts '****************************************************************************************************************'

puts "QUERIES !! "
puts 'Primary key value Query is as follows:'
database[:heroku_qwfkrl8f].find(:ID => '10').each {|document| puts document }

puts '****************************************************************************************************************'

puts 'Non Primary key value Query is as follows:'
database[:heroku_qwfkrl8f].find(:Title => 'Interpol').each {|document| puts document }

puts '****************************************************************************************************************'

puts "Enter the Artist name:";
$name=gets
database[:heroku_qwfkrl8f].find(:Title => $name).each {|document| puts document }

puts ($document)

puts '****************************************************************************************************************'
