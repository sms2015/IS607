#### Stacey Schwarcz ####
#### Week 4 Quiz ####

#These are all open ended questions, open to a range of reasonable interpretations. 
#Generous partial credit will be given, but don't be afraid to show off what you can do! 
#As usual, two questions will be selected for grading.

#Week 4 quiz is due end of day on Friday September19th.
#Download the Movies dataset from http://had.co.nz/data/movies/.
#Provide R code that supports your work/conclusions for each of the following:

#m <- read.table("C:/Users/trans_000/Documents/GitHub/IS607/IS607/movies.tab", sep="\t", header=TRUE, quote="", comment="")
m<-read.table("$Comedymovies.tab", sep="\t", header=TRUE, quote="", comment="")

#### 1. ####
#Show an appropriate visualization that displays the total number of movies for each decade.
require(ggplot2)
summary(m)
#1893 through 20005
m$decade<-trunc(m$year/10)*10
m$decade
#nrow(m)
#m$count<-rep(1,nrow(m))
#m$count

decade.chart<-hist(m$decade,main="Movies by Decade",xlab="Decade",ylab="Number of Movies",ylim=c(0,15000))
decade.chart

#see pdf for chart

#### 2. ####
#Show the average IMDB user rating for different genres of movies? 
#Has this changed over time?

ind1<-grep("Action", colnames(m))
ind2<-grep("Short", colnames(m))
names.genre<-colnames(m)[ind1:ind2]
Action.r<-m$Action*m$rating
Animation.r<-m$Animation*m$rating
Comedy.r<-m$Comedy*m$rating
Drama.r<-m$Drama*m$rating
Documentary.r<-m$Documentary*m$rating
Romance.r<-m$Romance*m$rating
Short.r<-m$Short*m$rating

genre.rating<-data.frame(m$decade,Action.r,Animation.r,Comedy.r,Drama.r,Documentary.r,Romance.r,Short.r)
genre.rating[2:8]
colnames(genre.rating)

nzmean <- function(x) {
  zvals <- x==0
  if (all(zvals)) 0 else mean(x[!zvals])
}

genre.avg<-sapply(genre.rating[2:8],nzmean)

require(reshape2)
genre.avg.melt<-melt(genre.avg, value.name="Average IMDB Rating")
options (digits=2)
genre.avg.melt
genre.avg.df<-data.frame(genre.avg,stringsAsFactors=FALSE)

#output Average IMDB rating for various genres:
#                       Average IMDB Rating
#Action.r               5.3
#Animation.r            6.6
#Comedy.r               6.0
#Drama.r                6.2
#Documentary            6.7
#Romance.r              6.2
#Short.r                6.5

#**** fix
#genre.chart<-hist(genre.avg,main="IMDB Rating by Genre",xlab="Genre",ylab="Average User Rating")

#get averages for each decade for each genre
decade.split<-split(genre.rating,genre.rating$m.decade)
x<-as.data.frame(sort(unique(m$decade)))
for (i in 2:8){
  genx<-sapply(seq_along(decade.split),function(x) nzmean(decade.split[[x]][[i]]))
  x<-data.frame(x,genx)
}

x
colnames(x)<-c("Decade",names.genre)
options(digits=2)
genre.rating.decade<-x
genre.rating.decade

#output:
#Average Rating by Decade by Genre
#     Decade Action Animation Comedy Drama Documentary Romance Short
#1    1890    0.0       0.0    4.7   3.8         4.8     0.0   4.9
#2    1900    5.0       5.5    5.2   5.1         4.5     5.3   4.8
#3    1910    6.4       6.2    6.3   6.6         6.2     6.3   6.1
#4    1920    6.9       6.6    6.9   6.9         7.1     7.1   6.7
#5    1930    6.1       6.4    6.3   6.2         6.0     6.2   6.4
#6    1940    6.5       6.8    6.5   6.5         6.3     6.6   6.6
#7    1950    5.9       6.8    6.4   6.3         5.8     6.4   6.5
#8    1960    5.6       6.2    5.9   6.2         6.5     6.4   6.2
#9    1970    5.4       6.7    5.4   5.8         6.6     6.1   6.5
#10   1980    5.0       6.8    5.4   6.0         6.7     6.0   6.6
#11   1990    4.9       6.4    5.6   5.9         6.5     5.9   6.2
#12   2000    5.6       6.6    6.1   6.4         7.1     6.1   6.9


#### 3. ####
#Is there a relationship between length of movie and movie rating?

#Answer: There does not appear to be much of a relationship, see attached charts

length.rating.scatter1<-plot(m$length~m$rating,data=m,xlab="movie rating",ylab="movie length")

#Consider movies with length less than 1000
m1<-subset(m,length<1000)
head(m1)
length.rating.scatter<-plot(m1$length~m1$rating,data=m1,xlab="movie rating",ylab="movie length (minutes)")

#length of movie by 30 minute interval categories
m$length.cat<-trunc(m$length/60)*60
length.catname<-sort(unique(m$length.cat))

length.rating<-data.frame(m$length.cat,m$rating)
length.split<-split(length.rating,length.rating$m.length.cat)

length.rating.avg<-sapply(seq_along(length.split),function(x) nzmean(length.split[[x]][[2]]))
length.rating.avg<-data.frame(length.catname,length.rating.avg)

colnames(length.rating.avg)<-c("Length","Avg Rating")
length.rating.avg
Length Rating

lr<-data.frame(length.rating.avg)
lr
length.rating.chart<-plot(lr$Avg.Rating~lr$Length,data=lr,xlab="movie length (minutes)",ylab="movie rating")

#output:
#This does not appear to show much of a relationship either
#      Length Avg Rating
#1       0    6.4
#2      60    5.7
#3     120    6.7
#4     180    7.1
#5     240    7.0
#6     300    7.2
#7     360    7.5
#8     480    5.7
#9     540    7.4
#10    600    8.4
#11    720    6.7
#12    840    5.5
#13   1080    3.0
#14   2880    6.4
#15   5220    3.8


#### 4. ####
#Is there a relationship between length of movie and genre?

#There appears to be a relationship between the length of the movie and the genre:
#Based on the table, films have different average lengths depending on genre, short films
#not surprisingly the shortest, while Action and Romance appear to be the longest.

#                       genre.length.avg
#Action.l                    99
#Animation.l                 20
#Comedy.l                    75
#Drama.l                     96
#Documentary.l               70
#Romance.l                   99
#Short.l                     14

ind1<-grep("Action", colnames(m))
ind2<-grep("Short", colnames(m))
names.genre<-colnames(m)[ind1:ind2]
Action.l<-m$Action*m$length
Animation.l<-m$Animation*m$length
Comedy.l<-m$Comedy*m$length
Drama.l<-m$Drama*m$length
Documentary.l<-m$Documentary*m$length
Romance.l<-m$Romance*m$length
Short.l<-m$Short*m$length

genre.length<-data.frame(m$decade,Action.l,Animation.l,Comedy.l,Drama.l,Documentary.l,Romance.l,Short.l)
genre.length[2:8]
colnames(genre.length)

nzmean <- function(x) {
  zvals <- x==0
  if (all(zvals)) 0 else mean(x[!zvals])
}

genre.length.avg<-sapply(genre.length[2:8],nzmean)
genre.length.df<-data.frame(genre.length.avg,stringsAsFactors=FALSE)

#output:
#
#                       genre.length.avg
#Action.l                    99
#Animation.l                 20
#Comedy.l                    75
#Drama.l                     96
#Documentary.l               70
#Romance.l                   99
#Short.l                     14

#### 5. ####
#Which other variable best predicts total number of votes that a movie received.

#answer:budget would likely have an impact but it doesn't look like there is enough data
#in this dataset for this variable to determine this.
