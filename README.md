1) What is your external datasource used to populate your heroku data sources?
http://stackoverflow.com/questions/16765864/extract-json-values-from-remote-api-with-ruby

2) what are heroku toolbelt commands used to run your script
heroku run bash
cd app/controllers/
ruby mongo_controller.rb  (for MongoDB)
ruby sql_controller.rb  (for PostgreSQL)

3) what aspects of the implementation did you find easy, if any, and why?
Pushing files to heroku and adding data sources

4) what aspects of the implementation did you find hard, if any, and why?
Working with redis. Had trouble fetching data and inserting the data.

# CSE5335-sxr7995-2
