CREATE DATABASE Broadband;

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

COPY TempTable (GNISID,MunicipalityName,MunicipalityType,
MuniPop,MuniUnits,MuniArea,County,Region,CableProv,NoUnitsCable,
pctUnitsCable,DSLProv,NoUnitsDSL,PctUnitsDSL,FiberProv,NoUnitsFiber,
PctUnitsFiber,WirelineProv,NoUnitsWireline,PctUnitsWireline,
WirelessProv,NoUnitsWireless,PctUnitsWirelss,SatelliteProv)

FROM 'C:/IS607/BroadbandData2.csv'
WITH 
	DELIMITER ','


CREATE TABLE CensusData AS
  SELECT GNISID,MunicipalityName,MunicipalityType,MuniPop,MuniUnits,
	MuniArea,County,Region
  FROM TempTable;

ALTER TABLE CensusData ADD PRIMARY KEY (GNISID);

CREATE TABLE Broadband AS
  SELECT GNISID,NoUnitsCable,NoUnitsDSL
  FROM TempTable;

---need to figure out syntax to add foreign key
ALTER TABLE Broadband ADD FOREIGN KEY (GNISID);


UPDATE WikiData
SET date_time = CURRENT_TIMESTAMP;


CREATE VIEW top5views AS
	SELECT *
	FROM WikiData
	ORDER BY pageviews DESC
	LIMIT 5;
