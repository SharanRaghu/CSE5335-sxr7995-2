#Referance : http://stackoverflow.com/questions/16765864/extract-json-values-from-remote-api-with-ruby
#http://zetcode.com/db/sqliteruby/connect/
require 'json'
require 'open-uri'
require 'pg'
i = 0
count = 1
quotes="'"
begin

puts "----------------------------------------------------------------------------------------"
    
    #Reference: http://www.rubydoc.info/gems/pg/0.11.0/PGconn  
    db = PGconn.open(:host => 'ec2-54-83-53-120.compute-1.amazonaws.com', :dbname => 'decsfihbnvrb8b', :user=> 'jqztcloyubtgeg', :password=> 'X6bVMcCBSZxmo2ufZYDAKC290U')
    
    db.exec "CREATE TABLE IF NOT EXISTS SongAlbum(ArtistId INTEGER PRIMARY KEY, Artist TEXT)"
    db.exec "DELETE FROM SongAlbum"

while i < 1  do
      #DATA SOURCE: http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=editors&api_key=4d7847876fa96f67f881aaf1b73e0e30&format=json
	    data = JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=editors&api_key=4d7847876fa96f67f881aaf1b73e0e30&format=json").read)

      #iterate through the Array of returned artists and print their names                                                                                 
      data["similarartists"]["artist"].each do |artist|
      
      #assigning each json object to variable	
      artistvar = quotes+artist["name"].tr('^A-Za-z0-9',' ')+quotes
      
      #inserting into the database table
      db.exec "INSERT INTO SongAlbum VALUES(#{count},#{artistvar})"
      
      puts "#{count} #{artistvar}"
      
      count = count + 1;
    end

    i = i + 1;
end
count = count - 1;

puts "***************************************************************************"

puts "Total Data Entries = #{count}"

puts "***************************************************************************"

puts "QUERIES !! "
puts "Primary key value Query is as follows: \s"
stm = db.exec "SELECT * FROM SongAlbum WHERE SongAlbum.ArtistId = 50" 

stm.each do |row|
     puts row
end
puts "***************************************************************************\s"

puts "Non Primary key value Query is as follows: \s"
stm = db.exec "SELECT * FROM SongAlbum WHERE SongAlbum.Artist = 'Interpol'" 

stm.each do |row|
     puts row
end
puts "***************************************************************************\s"

#Reference: http://stackoverflow.com/questions/4244611/pass-variables-to-ruby-script-via-command-line
puts "Primary key value (between 1 to 100):\s"
$primarykey=gets

stm = db.exec "SELECT * FROM SongAlbum WHERE SongAlbum.ArtistId =#{$primarykey}" 
stm.each do |row|
puts row 
end

puts "***************************************************************************\s"
end