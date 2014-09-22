Adam Stopek and Stacey Schwarcz
IS 607 Assignment 4

#movies <- read.table("C:/Users/adams/Downloads/movies.tab", sep="\t", header=TRUE, quote="", comment="")
movies<- read.table("C:/Users/trans_000/Documents/GitHub/IS607/IS607/movies.tab", sep="\t", header=TRUE, quote="", comment="")

##### Find the "Best" "Popular" movies#####
# We have chosen best to mean the highest rating
# Most popular has been chosen to mean the Most number of votes
# We will take a data frame with Year, Rating, and Number of Votes
   
data <- subset(movies, select=c("year","rating","votes"))
data$rank_rating <-c(rank(data$rating, ties.method = "random" ))
data$rank_votes <-c(rank(data$votes, ties.method = "random" ))
data$weighted_score <- (data$rank_rating+data$rank_votes)/2
data$count <- 1
year_score <- subset(data, select=c("year","weighted_score"))
year_count <- subset(data, select=c("year","count"))


yearly_avg_score <- aggregate(year_score$weighted_score, by=list(year_score$year), FUN=mean, na.rm=TRUE)
yearly_num_movies <- aggregate(year_count$count, by=list(year_count$year), FUN=sum, na.rm=TRUE)
names(yearly_avg_score)<- c("year","average_score")
names(yearly_num_movies)<- c("year","amount_of_movies")

###plyr usage of Join
#install.packages("plyr")
library(plyr)
joined_data <- join(yearly_avg_score, yearly_num_movies, by = "year", type = "inner", match = "all")

library(ggplot2)
score_plot <- ggplot(data=joined_data, aes(x=year, y=average_score)) + geom_line(size=1.5) + geom_point() 
number_of_movies_plot <- ggplot(data=joined_data, aes(x=year, y=amount_of_movies)) + geom_line(size=1.5) + geom_point()

#Graph of score
score_plot
#Graph of number of movies
number_of_movies_plot

#####
#Years with greater than 200 movies
joined_data_200<-joined_data[which(joined_data$amount_of_movies>=200),]
score_plot_200<-ggplot(joined_data_200, aes(x=year,y=average_score))+geom_line(size=1.5)
num_movies_plot_200<-ggplot(joined_data_200, aes(x=year,y=amount_of_movies))+geom_line(size=1.5)

#We noticed that the chart shows much higher average ratings for years before 1930,
#We also noticed that not surprisingly there were much fewer movies during this time period, or
#at least there are definitely fewer movies recorded and rated for these years in the database.
#We believe this may be due to people being more easily impressed by movies in early years
#since there were fewer movies and movies were a newer concept. It is more difficult to truly
#impress movie goers now as they may feel that they've seen it all before. Therefore we looked
#at the data for years with greater than 200 movies, essentially 1930 and after.

#Graph of score for years where number of movies is greater than 200
score_plot_200
#Graph of number of movies where number of movies is greater than 200
num_movies_plot_200

#####
#Year with the greatest number of popular, best movies, considering all years:
max_score<-max(joined_data$average_score)
row_max=which(joined_data$average_score==max_score)
max_year=joined_data$year[row_max]
max_year

#Year with greatest number of popular, best movies with greater than 200 movies (beginning 1930):
max_score_200<-max(joined_data_200$average_score)
row_max_200=which(joined_data_200$average_score==max_score_200)
max_year_200=joined_data_200$year[row_max_200]
max_year_200
