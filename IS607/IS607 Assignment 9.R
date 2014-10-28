#### Stacey Schwarcz  Week 9 Assignment ####

#install rmongodb
install.packages("rmongodb")
library(devtools)
install_github("rmongodb", "mongosoup")
library(rmongodb)
help("mongo.create")
mongo <- mongo.create()
mongo
mongo.is.connected(mongo)

#get mongodb databasee
if (mongo.is.connected(mongo) == TRUE) {
  mongo.get.databases(mongo)
}
#result: "employment"   "unitedstates"

#get mongodb collections in unitedstates database
if (mongo.is.connected(mongo) == TRUE) {
  db <- "unitedstates"
  mongo.get.database.collections(mongo,db)
}
#result:  "unitedstates.USdata"

#count number of documents/rows in a collection
DBNS <- "unitedstates.USdata"
mongo.count(mongo, ns = DBNS)
#result: 56

#look at the data:
viewData <- mongo.find.one(mongo, ns = "unitedstates.USdata")
viewData
#result: _id : 
#7    544ee9bec55048386cb685a2
#state : 2 	 Alabama
#abbr : 2 	 AL
#capital_city : 2 	 Montgomery
#largest_city : 2 	 Birmingham
#population : 16 	 4833722
#area_sq_miles : 16 	 52420
#land_area_sq_miles : 16 	 50645
#house_seats : 16 	 7
#statehood_date : 2 	 12/14/1819

#check the class of viewData
class(viewData)
#result:"mongo.bson"

#convert to list
find_all <- mongo.find.all(mongo, ns = DBNS)
find_all

#convert to data frame

#districtdata to dataframe
USdata.districtdata.df= as.data.frame(t(unlist(find_all[51])), stringsAsFactors = F)
n<-ncol(USdata.districtdata.df)
USdata.districtdata.df<-USdata.districtdata.df[,c(2:n)]


library(plyr)
## create empty data frames
USdata.statedata <- data.frame(stringsAsFactors = FALSE)
USdata.inhabitedterritorydata <- data.frame(stringsAsFactors = FALSE)

#statedata to dataframe
for (i in 1:50){
  tmp.df<- as.data.frame(t(unlist(find_all[i])), stringsAsFactors = F)
  USdata.statedata <- rbind.fill(USdata.statedata, tmp.df)
}

m<-ncol(USdata.statedata)
USdata.statedata.df<-USdata.statedata[,c(2:m)]

#inhabitedterritorydata to dataframe
for (i in 52:56){
  tmp.df<- as.data.frame(t(unlist(find_all[i])), stringsAsFactors = F)
  USdata.inhabitedterritorydata <- rbind.fill(USdata.inhabitedterritorydata, tmp.df)
}

p<-ncol(USdata.inhabitedterritorydata)
USdata.inhabitedterritorydata.df<-USdata.inhabitedterritorydata[,c(2:p)]

#### RESULTS #####

USdata.districtdata.df
#federal_district abbr establishment_date population area_sq_miles land_area_sq_miles house_seats
#1 "Washington, D.C."   DC          7/16/1790     646449            68                 61           1

head(USdata.statedata.df)
#   state    abbr   capital_city   largest_city population area_sq_miles land_area_sq_miles house_seats  statehood_date
#1  Alabama   AL     Montgomery     Birmingham    4833722         52420              50645           7    12/14/1819
#2  Alaska   AK       Juneau    Anchorage     735132        665384             570641           1   1/3/1959
#3  Arizona   AZ      Phoenix      Phoenix    6626624        113990             113594           9    8/1/1876
#4  Arkansas   AR  Little Rock  Little Rock    2959373         53179              52035           4   6/15/1836
#5  California   CA   Sacramento  Los Angeles   38332521        163695             155779          53   9/9/1850 
#6  Colorado   CO       Denver       Denver    5268367        104094             103642           7   8/1/1876

USdata.inhabitedterritorydata.df
#       territory             abbr   capital    acquisition_year    territorial_status      population
#1           American Samoa   AS        Pago Pago   1900 "Unincorporated, unorganized"      55519
#2                     Guam   GU          Hagatna   1899   "Unincorporated, organized"     159358
#3 Northern Mariana Islands   MP           Saipan   1986   "Unincorporated, organized"      53883
#4              Puerto Rico   PR         San Juan   1899   "Unincorporated, organized"    3725789
#5      U.S. Virgin Islands   VI Charlotte Amalie   1917   "Unincorporated, organized"     106405

#      area_sq_miles  land_area_sq_miles   house_seats
#1           581                 76           1
#2           571                210           1
#3          1976                182           1
#4          5325               3424           1
#5           733                134           1

