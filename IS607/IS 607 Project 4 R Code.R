#import broadband data
#broadband<-read.csv("c:/Users/trans_000/SkyDrive/Documents/IS 607/Project 4/Broadband_Availability_By_Municipality.csv")
broadband<-read.csv("T:/IS 607/project 4/Broadband_Availability_By_Municipality.csv")

#check names
names(broadband)

#adjust names
names(broadband)<-c("GNIS.ID","Municipality.Name","Municipality.Type",
                    "Muni.Pop","Muni.Units","Muni.Area","County","Region","Cable.Prov","No.Units.Cable","pct.Units.Cable",
                    "DSL.Prov","No.Units.DSL","Pct.Units.DSL","Fiber.Prov","No.Units.Fiber","Pct.Units.Fiber","Wireline.Prov",
                    "No.Units.Wireline","Pct.Units.Wireline","Wireless.Prov","No.Units.Wireless","Pct.Units.Wirelss","Satellite.Prov")

class(broadband)  #data.frame

#a- what are the top 5 counties for cable and for DSL broadband availability using total cable availability
#divided by total census households, and secondary sort value of total cable availability.

#create a data frame with region, county, housing units, cable units, and DSL units.
b.region.county <- subset(broadband, select=c("Region","County","Muni.Units","No.Units.Cable","No.Units.DSL"))
#aggregate households, cable units, and DSL units by county
b.county.sum<- setNames(aggregate(cbind(b.region.county$Muni.Units,b.region.county$No.Units.Cable,b.region.county$No.Units.DSL),
                                  by=list(b.region.county$County), FUN=sum, na.rm=TRUE),
                        c("County","HSE.Units","Cable.Units","DSL.Units"))
#find the household cable percentages by county
b.county.sum$Cable.Unit.pct<-b.county.sum$Cable.Units/b.county.sum$HSE.Units
#sort by percent cable and then by cable units
sort.county.Cable<-b.county.sum[order(-b.county.sum$Cable.Unit.pct,-b.county.sum$Cable.Units),]
top10.Cable<-sort.county.Cable[1:10,c(1,2,3,5)]
n=nrow(sort.county.Cable)
m<-n-10+1
bottom10.Cable<-sort.county.Cable[m:n,c(1,2,3,5)]

#find percentages and sort for DSL units
b.county.sum$DSL.Unit.pct<-b.county.sum$DSL.Units/b.county.sum$HSE.Units
sort.county.DSL<-b.county.sum[order(-b.county.sum$DSL.Unit.pct,-b.county.sum$Cable.Units),]
top10.DSL<-sort.county.DSL[1:10,c(1,2,4,6)]
bottom10.DSL<-sort.county.DSL[m:n,c(1,2,4,6)]


results<-setNames(data.frame(top10.Cable[,1],top10.DSL[,1],bottom10.Cable[,1],bottom10.DSL[,1]),c("Top 10 Cable","Top 10 DSL","Bottom 10 Cable","Bottom 10 DSL"))
results
