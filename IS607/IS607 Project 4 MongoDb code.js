mongoimport --collection broadband --type csv --headerline --file /Temp/Broadband_Availability_By_Municipality.csv
mongo.exe
db.broadband.find()

#first record
#{ "_id" : ObjectId("545cbac1d6a9172615a8c8aa"), "GNIS ID" : 978655, "Municipality Name" : "Adams",
# "Municipality Type" : "Town", "2010 Muni Population" : 5143,"2010 Muni Housing Units" : 2126, 
#"Muni Area (sq mi)" : 42.4, "County" : "Jefferson", "REDC Region" : "North Country Region", 
#"# Cable Providers" : 1, "# Hse Units Cable" : 1800, "% Hse Units Cable" : "85%", 
#"# of DSL Providers" : 1, "# Hse Units DSL" : 2000, "% Hse Units DSL" : "94%", 
#"# Fiber Providers" : 0, "# Hse Units Fiber" : 0, "% Hse Units Fiber" : "0%", 
#"# Wireline Providers" : 2, "# HseUnits Wireline" : 2000, "% Hse Units Wireline" : "94%", 
#"# Wireless Providers" : 4, "# Hse Units Wireless" : 2000, "% Hse Units Wireless" : "94%", 
#"# Satellite Providers" : 4 }

#import worked fine but the queries become problematic with some of the headers names, so 
#I edited the headers in the file and reimported

mongoimport --collection broadband2 --type csv --headerline --file /Temp/Broadband2.csv
mongo.exe
db.broadband2.find()

> db.broadband2.find()
{ "_id" : ObjectId("545d0e4fd6a9172615a8d55a"), "GNISID" : 978655, 
#"MunicipalityName" : "Adams", "MunicipalityType" : "Town", "MuniPopulation" : 5143, 
#"MuniHousingUnits" : 2126, "MuniArea" : 42.4, "County" : "Jefferson", 
#"REDCRegion" : "North Country Region", "CableProviders" : 1, "UnitsCable" : 1800, 
#"UnitsCablePct" : "85%", "DSLProviders" : 1, "UnitsDSL" : 2000, "UnitsDSLPct" : "94%", 
#"FiberProviders" : 0, "UnitsFiber" : 0, "Units FiberPct" : "0%", "WirelineProviders" : 2,
#"UnitsWireline" : 2000, "UnitsWirelinePct" : "94%", "Wireless Providers" : 4, 
#"UnitsWireless" : 2000, "UnitsWireless" : 2000, "SatelliteProviders" : 4 }

#code to return number of municipal housing units by county:
var map = function(){
	var value = {
	count:1,
	MuniHousingUnits: this.MuniHousingUnits
	};
	emit(this.County, value)
}

var reduce = function(keyCounty,valuesCombo){
	reducedVal = {count:0, MuniHousingUnits:0};
	for (var idx = 0; idx < valuesCombo.length; idx++){
	reducedVal.count += valuesCombo[idx].count;
	reducedVal.MuniHousingUnits += valuesCombo[idx].MuniHousingUnits;
	}
	return reducedVal;
	}

var finalize = function(key, reducedVal){
		return reducedVal;
		}

db.broadband2.mapReduce(map,reduce,
	{out: "mr_HousesByCounty",finalize: finalize}
	)

db.mr_HousesByCounty.find()
