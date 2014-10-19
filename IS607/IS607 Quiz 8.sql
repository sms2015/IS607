--Stacey Schwarcz
--Week 8 Quiz
--For this week’s quiz, you’re asked to store information about an organizational hierarchy in a relational database
--(PostgreSQL).

--Here is an (obviously not current) org chart for Apple Corporation:
--http://fortunedotcom.files.wordpress.com/2011/08/apple_org_chart_large1.jpg

--(1)--
--Create a single table that includes information for the CEO, the SVP of IOS Software, and the SVP, Chief Financial Officer. 
--Also include information for the direct reports of the two SVPs. [You should have a single table with 8 rows].

CREATE TABLE Employees (
	employeeId SERIAL,
	title VARCHAR(50) NOT NULL,
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	PRIMARY KEY (employeeId)
); 

INSERT INTO Employees (Title,firstName,lastName)
VALUES
    ('CEO','Steve','Jobs'),
    ('SVP, IOS Software','Scott','Forstall'),
    ('SVP, Chief Financial Officer','Peter','Oppenheimer'),
    ('VP, Program Management','Kim','Vorrath'),
    ('VP, IOS Wireless Software','Isabel','Ge Mahe'),
    ('VP, Engineerin IOS Apps','Henri','Lamiraux'),
    ('VP, Controller','Betsy','Rafael'),
    ('VP, Treasurer','Gary','Wipfler')
    ;


--(2)--
--Write a query that displays all of the information in the table.

SELECT
	*
FROM
	Employees

--result of query
--employeeId,title,firstName,lastName
--1;"CEO";"Steve";"Jobs"
--2;"SVP, IOS Software";"Scott";"Forstall"
--3;"SVP, Chief Financial Officer";"Peter";"Oppenheimer"
--4;"VP, Program Management";"Kim";"Vorrath"
--5;"VP, IOS Wireless Software";"Isabel";"Ge Mahe"
--6;"VP, Engineerin IOS Apps";"Henri";"Lamiraux"
--7;"VP, Controller";"Betsy";"Rafael"
--8;"VP, Treasurer";"Gary";"Wipfler"

--(3)--
--* NOTE: I don't see where a DELETE query is necessary here, update seems sufficient so I didn't
--use a DELETE query. Also the instructions do not say to add the direct reports of the COO, 
--just that they remain unchanged so I did not add these reports.

--Assume that 

--(a) Tim Cook replaces Steve Jobs as CEO, 
UPDATE 
	Employees
SET 
	firstName = 'Tim', 
	lastName='Cook'
WHERE 
	Title LIKE 'CEO';

--and (b) Apple (hypothetically) hires Susan Wojcicki away from Google to replace Tim Cook at COO, 
--with the COO reports unchanged.

INSERT INTO Employees (Title,firstName,lastName)
VALUES
    ('COO','Susan','Wojcicki');

--result of 3 
--employeeId,title,firstName,lastName
--1;"CEO";"Tim";"Cook"
--2;"SVP, IOS Software";"Scott";"Forstall"
--3;"SVP, Chief Financial Officer";"Peter";"Oppenheimer"
--4;"VP, Program Management";"Kim";"Vorrath"
--5;"VP, IOS Wireless Software";"Isabel";"Ge Mahe"
--6;"VP, Engineerin IOS Apps";"Henri";"Lamiraux"
--7;"VP, Controller";"Betsy";"Rafael"
--8;"VP, Treasurer";"Gary";"Wipfler"
--9;"COO";"Susan";"Wojcicki"

--Your deliverable should include:
--The script to create the table,
--The INSERT statements to populate the table, 
--and The SQL query to pull information from the table, and 
--The [INSERT, UPDATE, DELETE] SQL statements needed to update the information to reflect the new CEO and COO 
--as described in (3) above.
