#### Stacey Schwarcz ####
#### Week 5 Assignment: Tidying and Transforming Data ####
#In a recent mythical poll in Scotland, voters were asked if they preferred Cullen skink 
#over Partan bree. Here are the results of the poll, with results broken down by city and 
#by age group.

library(tidyr)
library(plyr)
library(dplyr)

#### 1. ####
#Write down 3 questions that you might want to answer based on this data.
#Question 1: What percentage of 16-24 said yes?
#Question 2: Was the percentage of 16-24 who said yes less than or greater than over 25 who said yes?
#Question 3: Did a larger percentage of Edinburgh or Glasgow answer yes?

#### 2.####
#Create an R data frame with 2 observations to store this data in its current "messy" state.
#Use whatever method you want to re-create and/or load the data.
poll_result<-c('Yes','no')
Edin.1624<-c(80100,35900)
Edin.25<-c(143000,214800)
Glas.1624<-c(99400,43000)
Glas.25<-c(150400, 207000)


data<-data.frame(poll_result,Edin.1624,Edin.25,Glas.1624,Glas.25,stringsAsFactors = FALSE)
data
#output:
#  poll_result Edin1624 Edin25 Glas1624   Glas25
#1      Yes    80100    143000    99400   150400
#2       no    35900    214800    43000   207000

#### 3.####
#Use the functionality in the tidyr package to convert the data frame to be "tidy data."

data2<-data %>%
  gather(City.group, count, -poll_result, convert = TRUE) %>%
  arrange(poll_result, City.group)
data2

#output
#   poll_result City.group  count
#1          no   Edin.1624  35900
#2          no     Edin.25 214800
#3          no   Glas1.624  43000
#4          no     Glas.25 207000
#5         Yes   Edin1.624  80100
#6         Yes     Edin.25 143000
#7         Yes   Glas1.624  99400
#8         Yes     Glas.25 150400

data3 <- data2 %>% 
  separate(City.group, into=c("City", "group"), sep = "\\.")
data3

#output
#poll_result City   group count
#1      Yes   Edin  1624  80100
#2      Yes   Edin    25 143000
#3      Yes   Glas  1624  99400
#4      Yes   Glas    25 150400
#5      no    Edin  1624  35900
#6      no    Edin    25 214800
#7      no    Glas  1624  43000
#8      no    Glas    25 207000


#### 4. ####
#Use the functionality in the plyr package to answer the questions that you asked in step 1.
aggregate(data3$count, by=list(data3$poll_result,data3$group), FUN=sum, na.rm=TRUE)
#output:
#Group.1 Group.2      x
#1      no    1624  78900
#2     Yes    1624 179500
#3      no      25 421800
#4     Yes      25 293400

data_city<-aggregate(data3$count, by=list(data3$poll_result,data3$City), FUN=sum, na.rm=TRUE)
#output:
#Group.1 Group.2      x
#1      no    Edin 250700
#2     Yes    Edin 223100
#3      no    Glas 250000
#4     Yes    Glas 249800


#### 5.####
#Having gone through the process, would you ask different questions and/or change the way 
#that you structured your data frame?
#I would change the way I structured the data frame, but not necessarily ask different questions.

