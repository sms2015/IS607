--Stacey Schwarcz
--IS 607 
--Week 13 Assignment

--1. Write a moderately complex JOIN query against two or more tables in the flights database. Measure
--the performance of the JOIN (at least twice to factor in caching issues). Next, create at least one index that
--should improve the performance of the join. Measure the performance of the join again. Your deliverable
--should include your recorded measurements, and the SQL code for both your join statement and to create
--the index(es) that you added. Why not just add indexes for every possible query?

--create table airport
CREATE TABLE airport (
Label CHAR(3),
City VARCHAR(50),
ST VARCHAR(50),
PRIMARY KEY (label)
); 

--create table flight
CREATE TABLE flight (
Flight INTEGER,
Airline VARCHAR(50),
Depart CHAR(3),
Arrive CHAR(3),
Capacity INTEGER,
Takeoff INTEGER,
Landing INTEGER,
PRIMARY KEY (Flight)
); 

--fill airport table with data
COPY airport (Label,City,ST) 
FROM 'C:/Temp/airport.csv'
WITH 
	DELIMITER ',' CSV
	HEADER;

--fill flight table with data 
COPY flight (Flight,Airline,Depart,Arrive,Capacity,Takeoff,Landing) 
FROM 'C:/Temp/flight.csv'
WITH 
	DELIMITER ',' CSV
	HEADER;

--create a join query to join find all departing flights from each airport
SELECT
	airport.*,
	flight.Flight,
	flight.Airline,
	flight.Depart,
	flight.capacity,
	flight.takeoff
	
FROM
	airport

INNER JOIN flight ON airport.Label = flight.depart

--time
--run 1: 11 ms
--run 2: 11 ms

--first 5 rows of results
--"ATL";"Atlanta";"Georgia";23;"Delta";"ATL";160;926
--"DTW";"Detroit";"Michigan";24;"Delta";"DTW";160;914
--"DTW";"Detroit";"Michigan";27;"Delta";"DTW";160;945
--"BOS";"Boston";"Massachussetts";28;"Delta";"BOS";160;1009
--"DTW";"Detroit";"Michigan";35;"Delta";"DTW";128;955

--create index on Label in the flight table
CREATE UNIQUE INDEX label_idx ON airport (Label)

--run the join query again
--time
--run 1: 11 ms
--run 2: 11 ms

--there was no change in the time when the index was added

--It doesn't make sense to add indices for every query because when changes are made
--to the underlying data the indices need to be recalculated.


--2. Write code that generates a new SQL table that includes information from at least two base tables, one new
--calculated column, and one “pre-stored aggregation.” Can you do the same thing with a SQL view? What
--are the advantages and disadvantages of the table vs. the view?
--Example: Show the net delay time, the seating capacity, and the average temperature and average
--windspeed for the day (or—harder--the duration of the flight) for each flight.

--create a table and then a view with the total capacity of departing flights
CREATE TABLE DCapacity AS
SELECT 
      Depart,
      SUM(Capacity) TotCapacity
FROM
      flight
WHERE 
      EXISTS (
SELECT
      airport.*,
      flight.Flight,
      flight.Airline,
      flight.Depart,
      flight.capacity,
      flight.takeoff
FROM
      airport
INNER JOIN flight ON airport.Label = flight.depart
)
GROUP BY
      Depart
;

--Execution time: 303 ms execution time

--create a view of the same data
CREATE VIEW DCapView AS
SELECT 
      Depart,
      SUM(Capacity) TotCapacity
FROM
      flight
WHERE 
      EXISTS (
SELECT
      airport.*,
      flight.Flight,
      flight.Airline,
      flight.Depart,
      flight.capacity,
      flight.takeoff
FROM
      airport
INNER JOIN flight ON airport.Label = flight.depart
)
GROUP BY
      Depart
;

--Execution time : 74 ms

--In a traditional view the view executes the underlying queries to build the view, whereas in 
--a table the queries are executed once to create the table but not every the time the table is called
--if the view is only needed once then the view may be preferable as it is faster to create but if the data
--is needed for additional queries then with respect to performance it is better to create a table.


--3. Find an R package that covers the same functionality as some base R code. Write some code to benchmark--
--probably with loaded or generated data of a reasonable size--to compare speed in the two environments).
--Publish your code and benchmark results at rpubs.com.
--Example: Compare the speed of a dplyr aggregation function and the corresponding “base R” apply()
--function against a reasonably-sized dataset; if you want, you may instead compare the speed of two R
--packages that perform the same function.

-- see R Markdown file



