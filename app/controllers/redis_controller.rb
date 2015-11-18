require 'json' 
require 'open-uri'
require 'redis' 

quotes="'"

data = Redis.new(:host => "ec2-54-83-9-36.compute-1.amazonaws.com", :port => 20409, :url => "redis://h:p5u8r65m6v6bp8ck1ms281tddss@ec2-54-83-9-36.compute-1.amazonaws.com:20409", :password => "p5u8r65m6v6bp8ck1ms281tddss") 


#fetch from data sourse API and store in a variable 
result = JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=editors&api_key=4d7847876fa96f67f881aaf1b73e0e30&format=json").read)

result["similarartists"]["artist"].each do |artist|
#var = quotes+artist["name"].tr('^A-Za-z0-9',' ')+quotes

#storing values intoredis database on heroku
puts "------------------------------------------------------------------------------------"

$i=0 
while $i < 100 do 
$name=result["similarartists"]["artist"][$i][1] 
$mbid=result["similarartists"]["artist"][$i][2] 

data.hset "row#{$i}","index",$i
data.hset "row#{$i}","name", $name
data.hset "row#{$i}","mbid", $mbid 
puts data.hgetall "row#{$i}" 
$i= $i + 1 
end 
puts "------------------------------------------------------------------------------------"

puts "Redis Database Stored" 

#fetching value from database 
puts "Enter index you want to retrieve.." 

$index=gets.chomp 
puts data.hgetall "row#{$index}"
puts "------------------------------------------------------------------------------------"
puts "Enter a name:" 
y=gets.chomp 
$n=1 
while $n < 1 do 
temp = data.hget "row#{$n}", "name" 
if temp == y 
puts data.hgetall "row#{$n}"
end 
$n+=1 
end
puts "------------------------------------------------------------------------------------"

end