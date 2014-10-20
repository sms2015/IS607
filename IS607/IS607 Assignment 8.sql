--Stacey Schwarcz
--Week 8 assignment

--You’re asked to design a small database that tracks blog posts, comments, and tags. You should:

--1.--
--Perform an Environmental Scan
--Identify a favorite blog that has comments and tags enabled. Spend a few minutes looking at the site, 
--and think about how posts, comments, and tags are related. 
--Deliverable: URL of a favorite blog (or other type of site) that implements posts, comments, and tags.

--Answer:
--Url: http://slice.mit.edu/


--2.--
--Design the Logical Database. Determine what are the entitities (tables) and relationships between these 
--entities (1:1, 1:M, M:M?). Determine what are the most important attributes (columns) for each entity. It is 
--fine to make simplifying assumptions here—for example, we don’t need to track multiple authors, or 
--votes/ratings on posts. [Please feel free to implement any of these after you’ve got the core assignment 
--working]. 
--Deliverable: an entity-relationship diagram (hand-drawn is acceptable).

--Answer:
--See attached pdf entity-relationship diagram


--3.--
--Implement the Physical Database. 
--Implement the database that you designed in step 1. 
--Here, your deliverable is the script that creates the tables.

CREATE TABLE Posts (
	postId SERIAL,
	title VARCHAR(255) NOT NULL,
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,	
	postDate DATE NOT NULL,
	PRIMARY KEY (postId)
);

CREATE TABLE inTags (
	postId INTEGER NOT NULL REFERENCES Posts(postId),
	inTag VARCHAR(50) NOT NULL
); 

CREATE TABLE postComments (
	postId INTEGER NOT NULL REFERENCES Posts(postId),
	commentDate DATE NOT NULL,
	commentName VARCHAR(50) NOT NULL,
	commentText VARCHAR(500) NOT NULL
); 

--4.--
--Populate the Physical Database with Sample Data. 
--Write INSERT statements that add a few rows to each of the tables, so that the appropriate (one-to-one and one-to-many) 
--relationships can be tested. 
--Deliverable: a single script with all of the insert statements.


INSERT INTO Posts (title,firstName,lastName,postDate)
VALUES
    ('Coding Towards Vietnam: edX in Translation','JOE', 'MCGONEGAL','2014-09-29'),
    ('Swords Into Plowshares: Reworking a Military Computer in 1972','NANCY', 'DUVERGNE SMITH','2014-09-22'),
    ('Are You 3D-Printing with Fair-Trade Filament?','JOE', 'MCGONEGAL','2014-08-06'),
    ('How Will Climate Change Impact the U.S.? MIT Alumni Explain.','JAY','LONDON','2014-05-13'),
    ('Faculty Forum Online: MIT’s Research in Women’s Health','JAY','LONDON','2014-03-06'),
    ('Tweets from Utility Companies? Sloan Says Yes','NICOLE','MORELL','2014-08-12'),
    ('Preventing a Chocolate Drought','NANCY', 'DUVERGNE SMITH','2014-04-29')
    ; 

INSERT INTO postComments (postId,commentDate,commentName,commentText)
VALUES
    (1,'2014-10-01','Minh Tue Vo',':) I would like to credit Mr. Nguyen Hoang An (a fellow coordinator of Vietnamese edX translation project and a passionate translator as well), Mr. Nguyen Cong Nam and other translators who have volunteered so much of their times to make the translation available online.'),
    (3,'2014-08-06','pipi','video??'),
    (3,'2014-08-06','Nicole Morell','Here’s a video of the process http://youtu.be/MOkB6PJLaH8'),
    (3,'2014-08-15','Balıkesir Haber','For Video thanks.'),
    (4,'2014-05-13','Anuncios gratis','I’m not optimistic about the future of Earth’s climate, I don’t trust the man'),
    (4,'2014-05-15','Modern Tailor','end of time is a bitter truth and we have to face it, we might be able to slow this process but one day it will collapse.'),
    (4,'2014-05-22','George Kimball','Someday historians will look back and wonder what happened to the scientific community when GW became popular in the late 20th century. The normal standards of scientific proof have been reduced to where they are meaningless'),
    (4,'2014-05-23','P. Michael Hutchins','I’ve worked through IPCC reports. What I don’t understand is: (imagine you’re talking to an engineer) What do the models really tell us? '),
    (5,'2014-03-10','Kathryn James','Some years ago at an MIT reunion (I received three degrees in EE from MIT), I learned that MIT was researching the Y chromosome to try to solve male fertility problems.'),
    (5,'2014-03-11','Carol Willing','Thank you for an informative Faculty Forum. Fascinating research and new major for learning about complex women’s health issues. Having friends coping with endometriosis, I am pleased that MIT is taking a leadership role'),
    (5,'2014-03-12','Christine Shadle','Thank you for an excellent talk. Near the end you said that endo is an inflammatory disease, and then, that “many other immune diseases wax and wane with pregnancy.” I find this confusing.'),
    (6,'2014-08-12','RemaxMajesty','social business oh good'),
    (7,'2014-05-02','C Prem Ambrose','Enjoyed the article” Preventing a Chocolate Drought,” very much. Like dark chocolates very much and everyone does. Some years ago, was very involved in imported chocolates on a small scale as a side business.')
    ;
    
INSERT INTO inTags(postId,inTag)
VALUES
    (1,'Classroom'),
    (1,'Engineering'),
    (2,'Alumni Life'),
    (2,'Engineering'),
    (2,'Remember When...'),
    (3,'Design'),
    (3,'Engineering'),
    (3,'In the News'),
    (4,'Alumnni Life'),
    (4,'Energy'),
    (4,'Health'),
    (4,'In the News'),
    (4,'Research'),
    (4,'Science'),
    (5,'Alumni Life'),
    (5,'Campus Culture'),
    (5,'Events'),
    (5,'Health'),
    (5,'Learning'),
    (5,'Research'),
    (6,'In the News'),
    (6,'Management'),
    (6,'Media'),
    (7,'In the News'), 
    (7,'Management')   
    ;

--5. --
--Query the Data. Here, your deliverables are to write 
--(1) a SQL query that returns all of the blog posts, with associated comments and tags;

CREATE VIEW allPosts AS
	SELECT
		Posts.*,
		inTags.inTag,
		postComments.commentDate,
		postComments.commentName,
		postComments.commentText
		
	FROM
		Posts
	INNER JOIN inTags ON Posts.postId = inTags.postId
	INNER JOIN postComments ON Posts.postId = postComments.postId
	;
	
--Result
--postId,title,firstName,lastName,postDate,inTag,commentDate,commentName,commentText
--1;"Coding Towards Vietnam: edX in Translation";"JOE";"MCGONEGAL";"2014-09-29";"Classroom";"2014-10-01";"Minh Tue Vo";":) I would like to credit Mr. Nguyen Hoang An (a fellow coordinator of Vietnamese edX translation project and a passionate translator as well), Mr. Nguyen Cong Nam and other translators who have volunteered so much of their times to make the translation available online."
--1;"Coding Towards Vietnam: edX in Translation";"JOE";"MCGONEGAL";"2014-09-29";"Engineering";"2014-10-01";"Minh Tue Vo";":) I would like to credit Mr. Nguyen Hoang An (a fellow coordinator of Vietnamese edX translation project and a passionate translator as well), Mr. Nguyen Cong Nam and other translators who have volunteered so much of their times to make the translation available online."
--3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06";"Design";"2014-08-15";"Balıkesir Haber";"For Video thanks."
--3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06";"Design";"2014-08-06";"Nicole Morell";"Here’s a video of the process http://youtu.be/MOkB6PJLaH8"
--3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06";"Design";"2014-08-06";"pipi";"video??"
--3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06";"Engineering";"2014-08-15";"Balıkesir Haber";"For Video thanks."
--3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06";"Engineering";"2014-08-06";"Nicole Morell";"Here’s a video of the process http://youtu.be/MOkB6PJLaH8"
--3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06";"Engineering";"2014-08-06";"pipi";"video??"
--3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06";"In the News";"2014-08-15";"Balıkesir Haber";"For Video thanks."
--3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06";"In the News";"2014-08-06";"Nicole Morell";"Here’s a video of the process http://youtu.be/MOkB6PJLaH8"
--3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06";"In the News";"2014-08-06";"pipi";"video??"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Alumnni Life";"2014-05-23";"P. Michael Hutchins";"I’ve worked through IPCC reports. What I don’t understand is: (imagine you’re talking to an engineer) What do the models really tell us? "
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Alumnni Life";"2014-05-22";"George Kimball";"Someday historians will look back and wonder what happened to the scientific community when GW became popular in the late 20th century. The normal standards of scientific proof have been reduced to where they are meaningless"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Alumnni Life";"2014-05-15";"Modern Tailor";"end of time is a bitter truth and we have to face it, we might be able to slow this process but one day it will collapse."
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Alumnni Life";"2014-05-13";"Anuncios gratis";"I’m not optimistic about the future of Earth’s climate, I don’t trust the man"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Energy";"2014-05-23";"P. Michael Hutchins";"I’ve worked through IPCC reports. What I don’t understand is: (imagine you’re talking to an engineer) What do the models really tell us? "
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Energy";"2014-05-22";"George Kimball";"Someday historians will look back and wonder what happened to the scientific community when GW became popular in the late 20th century. The normal standards of scientific proof have been reduced to where they are meaningless"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Energy";"2014-05-15";"Modern Tailor";"end of time is a bitter truth and we have to face it, we might be able to slow this process but one day it will collapse."
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Energy";"2014-05-13";"Anuncios gratis";"I’m not optimistic about the future of Earth’s climate, I don’t trust the man"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Health";"2014-05-23";"P. Michael Hutchins";"I’ve worked through IPCC reports. What I don’t understand is: (imagine you’re talking to an engineer) What do the models really tell us? "
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Health";"2014-05-22";"George Kimball";"Someday historians will look back and wonder what happened to the scientific community when GW became popular in the late 20th century. The normal standards of scientific proof have been reduced to where they are meaningless"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Health";"2014-05-15";"Modern Tailor";"end of time is a bitter truth and we have to face it, we might be able to slow this process but one day it will collapse."
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Health";"2014-05-13";"Anuncios gratis";"I’m not optimistic about the future of Earth’s climate, I don’t trust the man"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"In the News";"2014-05-23";"P. Michael Hutchins";"I’ve worked through IPCC reports. What I don’t understand is: (imagine you’re talking to an engineer) What do the models really tell us? "
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"In the News";"2014-05-22";"George Kimball";"Someday historians will look back and wonder what happened to the scientific community when GW became popular in the late 20th century. The normal standards of scientific proof have been reduced to where they are meaningless"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"In the News";"2014-05-15";"Modern Tailor";"end of time is a bitter truth and we have to face it, we might be able to slow this process but one day it will collapse."
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"In the News";"2014-05-13";"Anuncios gratis";"I’m not optimistic about the future of Earth’s climate, I don’t trust the man"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Research";"2014-05-23";"P. Michael Hutchins";"I’ve worked through IPCC reports. What I don’t understand is: (imagine you’re talking to an engineer) What do the models really tell us? "
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Research";"2014-05-22";"George Kimball";"Someday historians will look back and wonder what happened to the scientific community when GW became popular in the late 20th century. The normal standards of scientific proof have been reduced to where they are meaningless"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Research";"2014-05-15";"Modern Tailor";"end of time is a bitter truth and we have to face it, we might be able to slow this process but one day it will collapse."
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Research";"2014-05-13";"Anuncios gratis";"I’m not optimistic about the future of Earth’s climate, I don’t trust the man"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Science";"2014-05-23";"P. Michael Hutchins";"I’ve worked through IPCC reports. What I don’t understand is: (imagine you’re talking to an engineer) What do the models really tell us? "
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Science";"2014-05-22";"George Kimball";"Someday historians will look back and wonder what happened to the scientific community when GW became popular in the late 20th century. The normal standards of scientific proof have been reduced to where they are meaningless"
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Science";"2014-05-15";"Modern Tailor";"end of time is a bitter truth and we have to face it, we might be able to slow this process but one day it will collapse."
--4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13";"Science";"2014-05-13";"Anuncios gratis";"I’m not optimistic about the future of Earth’s climate, I don’t trust the man"
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Alumni Life";"2014-03-12";"Christine Shadle";"Thank you for an excellent talk. Near the end you said that endo is an inflammatory disease, and then, that “many other immune diseases wax and wane with pregnancy.” I find this confusing."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Alumni Life";"2014-03-11";"Carol Willing";"Thank you for an informative Faculty Forum. Fascinating research and new major for learning about complex women’s health issues. Having friends coping with endometriosis, I am pleased that MIT is taking a leadership role"
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Alumni Life";"2014-03-10";"Kathryn James";"Some years ago at an MIT reunion (I received three degrees in EE from MIT), I learned that MIT was researching the Y chromosome to try to solve male fertility problems."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Campus Culture";"2014-03-12";"Christine Shadle";"Thank you for an excellent talk. Near the end you said that endo is an inflammatory disease, and then, that “many other immune diseases wax and wane with pregnancy.” I find this confusing."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Campus Culture";"2014-03-11";"Carol Willing";"Thank you for an informative Faculty Forum. Fascinating research and new major for learning about complex women’s health issues. Having friends coping with endometriosis, I am pleased that MIT is taking a leadership role"
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Campus Culture";"2014-03-10";"Kathryn James";"Some years ago at an MIT reunion (I received three degrees in EE from MIT), I learned that MIT was researching the Y chromosome to try to solve male fertility problems."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Events";"2014-03-12";"Christine Shadle";"Thank you for an excellent talk. Near the end you said that endo is an inflammatory disease, and then, that “many other immune diseases wax and wane with pregnancy.” I find this confusing."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Events";"2014-03-11";"Carol Willing";"Thank you for an informative Faculty Forum. Fascinating research and new major for learning about complex women’s health issues. Having friends coping with endometriosis, I am pleased that MIT is taking a leadership role"
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Events";"2014-03-10";"Kathryn James";"Some years ago at an MIT reunion (I received three degrees in EE from MIT), I learned that MIT was researching the Y chromosome to try to solve male fertility problems."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Health";"2014-03-12";"Christine Shadle";"Thank you for an excellent talk. Near the end you said that endo is an inflammatory disease, and then, that “many other immune diseases wax and wane with pregnancy.” I find this confusing."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Health";"2014-03-11";"Carol Willing";"Thank you for an informative Faculty Forum. Fascinating research and new major for learning about complex women’s health issues. Having friends coping with endometriosis, I am pleased that MIT is taking a leadership role"
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Health";"2014-03-10";"Kathryn James";"Some years ago at an MIT reunion (I received three degrees in EE from MIT), I learned that MIT was researching the Y chromosome to try to solve male fertility problems."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Learning";"2014-03-12";"Christine Shadle";"Thank you for an excellent talk. Near the end you said that endo is an inflammatory disease, and then, that “many other immune diseases wax and wane with pregnancy.” I find this confusing."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Learning";"2014-03-11";"Carol Willing";"Thank you for an informative Faculty Forum. Fascinating research and new major for learning about complex women’s health issues. Having friends coping with endometriosis, I am pleased that MIT is taking a leadership role"
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Learning";"2014-03-10";"Kathryn James";"Some years ago at an MIT reunion (I received three degrees in EE from MIT), I learned that MIT was researching the Y chromosome to try to solve male fertility problems."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Research";"2014-03-12";"Christine Shadle";"Thank you for an excellent talk. Near the end you said that endo is an inflammatory disease, and then, that “many other immune diseases wax and wane with pregnancy.” I find this confusing."
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Research";"2014-03-11";"Carol Willing";"Thank you for an informative Faculty Forum. Fascinating research and new major for learning about complex women’s health issues. Having friends coping with endometriosis, I am pleased that MIT is taking a leadership role"
--5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06";"Research";"2014-03-10";"Kathryn James";"Some years ago at an MIT reunion (I received three degrees in EE from MIT), I learned that MIT was researching the Y chromosome to try to solve male fertility problems."
--6;"Tweets from Utility Companies? Sloan Says Yes";"NICOLE";"MORELL";"2014-08-12";"In the News";"2014-08-12";"RemaxMajesty";"social business oh good"
--6;"Tweets from Utility Companies? Sloan Says Yes";"NICOLE";"MORELL";"2014-08-12";"Management";"2014-08-12";"RemaxMajesty";"social business oh good"
--6;"Tweets from Utility Companies? Sloan Says Yes";"NICOLE";"MORELL";"2014-08-12";"Media";"2014-08-12";"RemaxMajesty";"social business oh good"
--7;"Preventing a Chocolate Drought";"NANCY";"DUVERGNE SMITH";"2014-04-29";"In the News";"2014-05-02";"C Prem Ambrose";"Enjoyed the article” Preventing a Chocolate Drought,” very much. Like dark chocolates very much and everyone does. Some years ago, was very involved in imported chocolates on a small scale as a side business."
--7;"Preventing a Chocolate Drought";"NANCY";"DUVERGNE SMITH";"2014-04-29";"Management";"2014-05-02";"C Prem Ambrose";"Enjoyed the article” Preventing a Chocolate Drought,” very much. Like dark chocolates very much and everyone does. Some years ago, was very involved in imported chocolates on a small scale as a side business."


--(2) a SQL query that returns all of the posts for a given tag.
--code to organize posts by tag (see below for code to pull up posts for a specific tag).

CREATE VIEW postByTag AS
	SELECT
		inTags.inTag,
		Posts.*
			
	FROM
		Posts
	INNER JOIN inTags ON Posts.postId = inTags.postId
	ORDER BY inTags.inTag
	;

--result
--intag,postid,title,firstName,lastName,postDate
--"Alumni Life";5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06"
--"Alumni Life";2;"Swords Into Plowshares: Reworking a Military Computer in 1972";"NANCY";"DUVERGNE SMITH";"2014-09-22"
--"Alumnni Life";4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13"
--"Campus Culture";5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06"
--"Classroom";1;"Coding Towards Vietnam: edX in Translation";"JOE";"MCGONEGAL";"2014-09-29"
--"Design";3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06"
--"Energy";4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13"
--"Engineering";3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06"
--"Engineering";2;"Swords Into Plowshares: Reworking a Military Computer in 1972";"NANCY";"DUVERGNE SMITH";"2014-09-22"
--"Engineering";1;"Coding Towards Vietnam: edX in Translation";"JOE";"MCGONEGAL";"2014-09-29"
--"Events";5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06"
--"Health";5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06"
--"Health";4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13"
--"In the News";6;"Tweets from Utility Companies? Sloan Says Yes";"NICOLE";"MORELL";"2014-08-12"
--"In the News";7;"Preventing a Chocolate Drought";"NANCY";"DUVERGNE SMITH";"2014-04-29"
--"In the News";4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13"
--"In the News";3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06"
--"Learning";5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06"
--"Management";7;"Preventing a Chocolate Drought";"NANCY";"DUVERGNE SMITH";"2014-04-29"
--"Management";6;"Tweets from Utility Companies? Sloan Says Yes";"NICOLE";"MORELL";"2014-08-12"
--"Media";6;"Tweets from Utility Companies? Sloan Says Yes";"NICOLE";"MORELL";"2014-08-12"
--"Remember When...";2;"Swords Into Plowshares: Reworking a Military Computer in 1972";"NANCY";"DUVERGNE SMITH";"2014-09-22"
--"Research";4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13"
--"Research";5;"Faculty Forum Online: MIT’s Research in Women’s Health";"JAY";"LONDON";"2014-03-06"
--"Science";4;"How Will Climate Change Impact the U.S.? MIT Alumni Explain.";"JAY";"LONDON";"2014-05-13"


--code to pull up posts for a specific tag, in this case 'Engineering'

CREATE VIEW postBySpecificTag AS
	SELECT
		inTags.inTag,
		Posts.*
			
	FROM
		Posts
	INNER JOIN inTags ON Posts.postId = inTags.postId
	WHERE
		inTags.inTag LIKE 'Engineering'
	;

--result
--intag,postid,title,firstName,lastName,postDate
--"Engineering";1;"Coding Towards Vietnam: edX in Translation";"JOE";"MCGONEGAL";"2014-09-29"
--"Engineering";2;"Swords Into Plowshares: Reworking a Military Computer in 1972";"NANCY";"DUVERGNE SMITH";"2014-09-22"
--"Engineering";3;"Are You 3D-Printing with Fair-Trade Filament?";"JOE";"MCGONEGAL";"2014-08-06"


