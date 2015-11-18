# Referance : http://stackoverflow.com/questions/16765864/extract-json-values-from-remote-api-with-ruby
#http://zetcode.com/db/sqliteruby/connect/
require 'json'
require 'open-uri'
require 'rubygems'
require 'mongo'

include Mongo

i = 0
var = 0

db = Mongo::Client.new([ 'ds053964.mongolab.com:53964' ], :database => 'heroku_qksst9vt', :user => 'sharan', :password => 'sharan')
puts '-------------------------------------------------------------------------------------------------------------------------'
while i < 1  do
	#DATA SOURCE: http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=editors&api_key=4d7847876fa96f67f881aaf1b73e0e30&format=json 
    data = JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=editors&api_key=4d7847876fa96f67f881aaf1b73e0e30&format=json").read)
      
      # iterate through the Array of returned artists and print their names                                                                                 
        data["similarartists"]["artist"].each do |artist|
        
        insertintable = db[:heroku_qksst9vt].insert_one({ID: var.to_s, Title: artist["name"]})
        
        var = var + 1;
      end

    i = i + 1;
end
puts '****************************************************************************************************************'

puts "Total Data Entries = #{var}"

puts '****************************************************************************************************************'

puts "QUERIES !! "
puts 'Primary key value Query is as follows:'
db[:heroku_qksst9vt].find(:ID => '10').each {|document| puts document }

puts '****************************************************************************************************************'

puts 'Non Primary key value Query is as follows:'
db[:heroku_qksst9vt].find(:Title => 'Interpol').each {|document| puts document }

puts '****************************************************************************************************************'

puts "Enter the Artist name:";
$name=gets
db[:heroku_qksst9vt].find(:Title => $name).each {|document| puts document }

puts ($document)

puts '****************************************************************************************************************'
