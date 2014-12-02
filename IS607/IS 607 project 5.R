#Stacey Schwarcz
#IS 607 Project 5

#1. Load a dataset from R or PostgreSQL into Neo4j. For example, you could load the PostgreSQL flights data into
#Neo4j. You're encouraged to find a different dataset to load that you might find even more interesting.
#2. Document your load process, in a way that is reproducible (so that I can test your work "soup to nuts" without 
#needing to access your machine!)
#3. Write at least one Cypher query against your newly created Neo4j database.
#4. What are the advantages and disadvantages of having this information in a graph database instead of a relational
#database?

#Import the Jeopardy questions data set
#source: http://j-archive.com/
#https://mega.co.nz/#!nVx0DQSR!OZvS2LPzNCOC-BejKoFp2wZEYakHO-EQUR1eL0plygM
options(stringsAsFactors = FALSE)

jeopardy<-read.csv("C:/temp/JEOPARDY_CSV.csv", header = TRUE, sep = ",")
head(jeopardy)
#convert data in Value column to numeric
jeopardy$Value<-as.character(jeopardy$Value)
jeopardy$Value<-sub(",","",jeopardy$Value)
jeopardy$Value<-sub("\\$","",jeopardy$Value)
jeopardy$Value<-as.numeric(jeopardy$Value)
options(digits=0)
names(jeopardy)[names(jeopardy)=="Show.Number"] <- "showNumber"
names(jeopardy)[names(jeopardy)=="Air.Date"] <- "airDate"

#to make the data more manageable for this project, it will be truncated to the data for just four Jeopardy shows

jeopardyTrunc<-jeopardy[c(1:236),]
jeopardyTrunc$clueId<-c(1:236)

#the shows and clues dataframe will be calculated later since it is necessary to reduce the number 
#of observations for Neo4J graph to be visible (see below)

#create a data frame for the node "Show" with unique shows with their air date.
shows=unique(data.frame('showNumber'=jeopardyTrunc$showNumber,
                        'airDate'=jeopardyTrunc$airDate))
head(shows)
#write to a csv file
write.csv(shows,file="C:/temp/shows.csv",row.names=F)

#create a data frame for the node "Clue"
clues=unique(data.frame('clueId'=jeopardyTrunc$clueId,
                        'question'=jeopardyTrunc$Question,
                        'answer'=jeopardyTrunc$Answer,
                        'value'=jeopardyTrunc$Value))
head(clues)
#write to a csv file
write.csv(clues,file="C:/temp/clues.csv",row.names=F)

#break each round into a separate file for the Round relationships in Neo4J
uniqueRound=unique(jeopardy$Round)
l=length(uniqueRound)

#create data frames for each Round type (Jeopardy, Double Jeopardy, and Final Jeopardy)
jeop<-jeopardyTrunc[jeopardyTrunc$Round == uniqueRound[1],]
doubleJ<-jeopardyTrunc[jeopardyTrunc$Round == uniqueRound[2],]
finalJ<-jeopardyTrunc[jeopardyTrunc$Round == uniqueRound[3],]
#tiebreak round is excluded to simplify the analysis
#tiebreak<-jeopardy[jeopardy$Round == uniqueRound[4],]

#create a csv file for each round type for Neo4J
write.csv(jeop,file="C:/temp/jeop.csv",row.names=F)
write.csv(doubleJ,file="C:/temp/doublej.csv",row.names=F)
write.csv(finalJ,file="C:/temp/finalj.csv",row.names=F)
