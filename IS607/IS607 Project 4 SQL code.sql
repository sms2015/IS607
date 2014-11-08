CREATE DATABASE Broadband;

--create table to hold imported data
CREATE TABLE TempTable (
GNISID INTEGER,
MunicipalityName VARCHAR(255),
MunicipalityType VARCHAR(255),
MuniPop INTEGER,
MuniUnits INTEGER,
MuniArea NUMERIC,
County VARCHAR(255),
Region VARCHAR(255),
CableProv INTEGER,
NoUnitsCable INTEGER,
pctUnitsCable NUMERIC,
DSLProv INTEGER,
NoUnitsDSL INTEGER,
PctUnitsDSL NUMERIC,
FiberProv INTEGER,
NoUnitsFiber INTEGER,
PctUnitsFiber NUMERIC,
WirelineProv INTEGER,
NoUnitsWireline INTEGER,
PctUnitsWireline NUMERIC,
WirelessProv INTEGER,
NoUnitsWireless INTEGER,
PctUnitsWirelss NUMERIC,
SatelliteProv INTEGER
);

--import data into table
COPY TempTable (GNISID,MunicipalityName,MunicipalityType,
MuniPop,MuniUnits,MuniArea,County,Region,CableProv,NoUnitsCable,
pctUnitsCable,DSLProv,NoUnitsDSL,PctUnitsDSL,FiberProv,NoUnitsFiber,
PctUnitsFiber,WirelineProv,NoUnitsWireline,PctUnitsWireline,
WirelessProv,NoUnitsWireless,PctUnitsWirelss,SatelliteProv)

FROM 'C:/IS607/BroadbandData2.csv'
WITH 
	DELIMITER ','

--split TempTable into two separate tables, CensusData and Broadband
CREATE TABLE CensusData AS
  SELECT GNISID,MunicipalityName,MunicipalityType,MuniPop,MuniUnits,
	MuniArea,County,Region
  FROM TempTable;

--create primary key from GNISID for CensusData table
ALTER TABLE CensusData ADD PRIMARY KEY (GNISID);

--create table Broadband, with just information on cable and DSL units
CREATE TABLE Broadband AS
  SELECT GNISID,NoUnitsCable,NoUnitsDSL
  FROM TempTable;

--add a foreign key constraint
ALTER TABLE Broadband ADD CONSTRAINT bbfk FOREIGN KEY (GNISID) 
	REFERENCES Broadband (GNISID) MATCH FULL;
	
--use inner join to create a new table with cable units and homes 
CREATE TABLE CableDSL AS
	SELECT
		Broadband.GNISID,
		Broadband.NoUnitsCable,
		Broadband.NoUnitsDSL,
		CensusData.MuniUnits,
		CensusData.County	
	FROM
		Broadband
	INNER JOIN CensusData ON Broadband.GNISID = CensusData.itemId
	;

--group by county and sum housing units, cable units, and dsl units
--help source: http://stackoverflow.com/questions/13118356/postgresql-group-by-with-sum
CREATE TABLE MunicipalUnits AS
	SELECT County, SUM(MuniUnits) totalQuantity
		FROM CableDSL
		GROUP BY County
		ORDER BY County;

CREATE TABLE CableUnits AS
	SELECT County, SUM(NoUnitsCable) totalQuantity
		FROM CableDSL
		GROUP BY County
		ORDER BY County;
	
CREATE TABLE DSLUnits AS
	SELECT County, SUM(NoUnitsDSL) totalQuantity
		FROM CableDSL
		GROUP BY County
		ORDER BY County;
		
--inner join MunicipalUnits, CableUnits, and DSLUnits to create one table
--new joined table will be FinalDataSet

--calculate CableUnits/MunicipalUnits and DSLUnits/MunicipalUnits	
--help source: http://stackoverflow.com/questions/18966747/postgresql-multiplication-of-columns

--use the following code in coordination with the calculated fields below to add columns to the dataset
ALTER TABLE FinalDataSet ADD COLUMN [....] NUMERIC;

--
SELECT SUM(NoUnitsCable / MuniUnits) AS PctCable 
FROM   FinalDataSet;

SELECT SUM(NoUnitsDSL / MuniUnits) AS PctDSL
FROM   FinalDataSet;

--format of final data set
--County VARCHAR(255),
--MuniUnits INTEGER,
--NoUnitsCable INTEGER,
--NoUnitsDSL INTEGER,
--pctCable NUMERIC,
--pctDSL NUMERIC

CREATE VIEW top10Cable AS
	SELECT *
	FROM FinalDataSet
	ORDER BY PctCable DESC
	LIMIT 10;
	
CREATE VIEW top10DSL AS
	SELECT *
	FROM FinalDataSet
	ORDER BY PctCable DESC
	LIMIT 10;
	
--use OFFSET and LIMIT to return bottom 10
