CREATE DATABASE project3;


CREATE TABLE WikiData (
  date_time TIMESTAMP,
  projectcode VARCHAR(50),
  pagename VARCHAR(255) UNIQUE,
  pageviews INTEGER,
  bytes INTEGER,
  PRIMARY KEY (projectcode,pagename)
); 


COPY WikiData ( projectcode,pagename,pageviews,bytes ) 
  FROM 'C:/Temp/20141001140000.txt'
  WITH 
	DELIMITER ' ';


UPDATE WikiData
  SET date_time = CURRENT_TIMESTAMP;


CREATE VIEW top5views AS
	SELECT *
	FROM WikiData
	ORDER BY pageviews DESC
	LIMIT 5;
