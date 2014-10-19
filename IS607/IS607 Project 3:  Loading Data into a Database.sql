--This creates the database 'project3'
CREATE DATABASE project3;

--Project Instructions
--Show the structure of the table(s) that you created. 
--(A single table is acceptable; you’ll need to create the database and table(s)).

--This is the table structure. I created only one table WikiData.
CREATE TABLE WikiData (
  date_time TIMESTAMP,  --see note below on this column
  projectcode VARCHAR(50),
  pagename VARCHAR(255) UNIQUE,
  pageviews INTEGER,
  bytes INTEGER,
  PRIMARY KEY (projectcode,pagename)
); 

--Thinking about the following instructions in the project:
--'Your long term task (which you are not going to do in this course, but you need to design for accordingly) 
--is to load all 16 months of data into a single database.'
--I added the date_time column to allow for data from each hour to be entered as a separate table
--It wasn't clear to me which date and hour the sample data was from so I just used CURRENT_TIMESTAMP to fill this field
--as an example
--If I were creating a table for each hour, I would name the file with the hour it came from instead of 'WikiData'

--This fills the new table with data from the sample file
COPY WikiData ( projectcode,pagename,pageviews,bytes ) 
  FROM 'C:/Temp/20141001140000.txt'
  WITH 
	DELIMITER ' ';

--This adds the date and time of the file, which is not directly included in the text file
UPDATE WikiData
  SET date_time = CURRENT_TIMESTAMP;


--Provide the SQL script to show the five most often visited Wikipedia pages.

--This creates a view of the query that shows the five most often visited Wikipedia pages based on the number of pageviews
CREATE VIEW top5views AS
	SELECT *
	FROM WikiData
	ORDER BY pageviews DESC
	LIMIT 5;

--result of top5views query
--projectcode,pagename,pageviews,bytes
--"2014-10-12 17:03:13.492";"en";"Database";257;14268896
--"2014-10-12 17:03:13.492";"en";"Data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAuCAIAAABmjeQ9AAAARElEQVR42mVO2wrAUAhy/f8fz%2BniVMTYQ3hLKkgGgN/IPvgIhUYYV/qogdP75J01V%2BJwrKZr/5YPcnzN3e6t7l%2B2K%2BEFX91B1daOi7sAAAAASUVORK5CYII%3D";220;1729420
--"2014-10-12 17:03:13.492";"en";"Data";203;8573050
--"2014-10-12 17:03:13.492";"en";"Data_mining";196;15613111
--"2014-10-12 17:03:13.492";"en";"Data_Protection_Act_1998";174;3733159
