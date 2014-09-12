####Stacey Schwarcz Week 3 Quiz Questions####
#The answers to the following [17] questions should be placed in a single R script.
#Place your R script in a public repository on github and submitting a link to the 
#script here. Label your answers using comments so that they can be clearly and quickly
#found within the script.

####1.####
#Write a function that takes a numeric vector and calculates the mean of 
#the observations in the vector.
v=1:25
v
num.vec<-function()
  {
  mean(v)
}
num.vec()
#output
#vector: 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
# mean: 13

#### 2.####
#Modify your function in the previous question so that it can handle a numeric 
#vector with missing values.
v2<- c(1:5,NA,NA,20:30)
v2
num.vec2<-function()
{
  mean(v2,na.rm=TRUE)
}

num.vec2()

#output: 
#v2: 1  2  3  4  5 NA NA 20 21 22 23 24 25 26 27 28 29 30
#mean: 18.125


#### 3.####
#Write a function that takes two numeric input values and calculates the greatest 
#common divisor of the two numbers.
a=10
b=20
GCD<-function(a,b)
{
  #which input is greater
  bigger<-max(a,b)
  smaller<-min(a,b)
  #create a vector from 1 to the smaller
  div.vec<-1:smaller
  #calculate remainders for both inputs
  big<-bigger%%div.vec
  small<-smaller%%div.vec
  #determine which have remainder 0
  big0<-which(big %in% 0)
  small0<-which(small %in% 0)
  #find the greatest common divisor of the inputs
  maxindex=max(which(small0 %in% big0))
  small0[maxindex]
}
  
GCD(a,b)

#output
# a=10, b=20  GCD=10
# a=3, b=20, GCD=1


#### 4. ####
#Write a function that implements Euclid's algorithm (you may need to do a bit of 
#research to find this algorithm) for finding the greatest common divisor of two 
#numeric inputs.
c=15
d=20
Euclid.GCD<-function(c,d)
{
  #absolute values
  c=abs(c)
  d=abs(d)
  #which input is greater
  dividend<-max(c,d)
  divisor<-min(c,d)
  quotient<-dividend%/%divisor
  remainder<-dividend%%divisor
  while (remainder != 0) 
  {
    dividend<-divisor*quotient+remainder
    dividend<-divisor
    divisor<-remainder
    quotient<-dividend%/%divisor
    remainder<-dividend%%divisor
  } 
  print(divisor)
}

Euclid.GCD(c,d)
#output
# c=20, d=10, Euclid.GCD = 10
# c=3, d=20, Euclid.GCD = 1
# c=20, d=15, Euclid.GCD = 5


#### 5. ####
#Write a function that takes two numeric inputs x and y and calculates x^2y+2xy-xy^2
x<-2
y<-5
xyfunction<-function(x,y)
  {
  x^2*y+2*x*y-x*y^2
}

xyfunction(x,y)
#output
# x=5,y=2, solution= 50
# x=2,y=5, solution= -10 

#### 6. ####
#Read in the week-3-price-data.csv and week-3-make-model-data.csv files as data frames 
#and then merge them by the ModelNumber key. Leave the "all" parameters as their defaults. 
#How many observations end up in the result? Is this what you would have expected?
week3.price<-read.csv("c:/IS 607/week-3-price-data.csv")
week3.makemodel<-read.csv("c:/IS 607/week-3-make-model-data.csv")
week3merge=merge(week3.price,week3.makemodel,"ModelNumber")
nrow(week3merge)
#output: 27 observations.  I woul dhave expected 28 since the larger file has 28 observations
#but it looks like one of the observations in the price file has a model number that 
#does not match any in the make and model number.


### #7. ####
#Use the data sets from the previous question, but this time merge them so that the 
#rows from the price-data table all appear, even if there is no match in the make-model
#table.
merge.allPriceRows=merge(week3.price,week3.makemodel,"ModelNumber",all.x=TRUE)
#output: 28 observations of 8 variables


#### 8. ####
#Take your result from question 7 and subset it so that only the 2010 vehicles are included.
subset2010<-subset(merge.allPriceRows, Year==2010)
#output: 14 observations of 8 variables

#### 9. ####
#Take your result from question 7 and subset it so that only the red cars that cost more 
#than $10,000 are included.
subset.red10000<-subset(merge.allPriceRows, Color =='Red' & Price>10000)
#output: 4 observations of 8 variables

#### 10. ####
#Take your result from question 9 and subset it so that the ModelNumber and Color columns 
#are removed.
remove.model.color<-subset(merge.allPriceRows,select= -ModelNumber)
remove.model.color<-subset(remove.model.color,select= -Color)
#output: 28 observations, 6 variables

#### 11. ####
#Write a function that takes as input a character vector and returns a numeric vector 
#with the numbers of characters in each of the elements in the original vector.
v=<-as.character(c("apple","orange","grape"))
ncharfunction<-function(v)
{
  nchar(v)
}
ncharfunction(v)
#output
# 5 6 5 

#### 12.####
#Write a function that takes two character vectors of equal length and concatenates 
#them element by element with a space as the separator. Have the function die gracefully 
#if the vectors are not the same length.

i<-as.character(c("red","yellow","green"))
j<-as.character(c("apple","lemon","grape"))
twovectors<-function(i,j)
{
  if (length(i)!=length(j)){
    stop("vectors are not the same length")
  }
  paste(i,j, sep=" ") 
}
twovectors(i,j)
# output
# vectors of equal length: "red apple"    "yellow lemon" "green grape" 
# error when not same length: Error in twovectors(i, j) : vectors are not the same length


#### 13. [incomplete] ####
#Write a function that takes a character vector and returns the substring of three 
#characters that begins with the first vowel in the string. Have the function handle 
#gracefully substrings where this isn't possible.
k<-as.character(c("apple","orange","grape","plum"))
vowels<-as.character(c("a","e","i","o","u"))
threechar<-function(k)
{ 
  k[1]
  a=regexpr("a",k[1])
  e=regexpr("e",k[1])
  i=max(0,regexpr("i",k[1]))
  o=max(0,regexpr("o",k[1]))
  u=max(0,regexpr("u",k[1]))
  
  startk=nchar(k)
  startk
  a=regexpr("a",k)
  e=regexpr("e",k)
  i=regexpr("i",k)
  o=regexpr("o",k)
  u=regexpr("u",k)
  a
  e
  i
  o
  u
  substr(k,startk)
   
}


#### 14. ####
#Suppose you have a data frame where one column gives the month (in numeric format), 
#the next gives the day, and the third column gives the year. Use R to create such a 
#data frame (by hand is fine) and then add a fourth column with the date in date format.
months=c(2,5,7,9)
days=c(4,7,20,25)
years=c(2001,2010,2012,2014)
dateframe<-data.frame(months,days,years)
dateframe
datefield<-ISOdate(years,months,days)
fulldate<-as.Date(datefield)
dateframe<-data.frame(dateframe,date=fulldate)
dateframe

#output:
#date frame
#   months days years
#1      2    4  2001
#2      5    7  2010
#3      7   20  2012
#4      9   25  2014
#
#data frame with full date
#months days years       date
#1      2    4  2001 2001-02-04
#2      5    7  2010 2010-05-07
#3      7   20  2012 2012-07-20
#4      9   25  2014 2014-09-25

#### 15. ####
#Illustrate the code necessary to take a string of MM-DD-YYYY format and convert it 
#to a date.
strdate <- "10-11-2004"
ndate <- as.Date(strdate, "%m-%d-%Y")
ndate
#output: "2004-10-11"


#### 16. ####
#Illustrate the code necessary to take a date and extract the month of the date.
a<-strptime("2004-10-20",format="%Y-%m-%d")
a$mon+1
#output: 10

#### 17. ####
#Create a sequence of all of the dates from January 1, 2005, to December 31, 2014.
seq(as.Date('2005-01-01'),as.Date('2014-12-31'),by = 1)
#partial output:
#[1] "2005-01-01" "2005-01-02" "2005-01-03" "2005-01-04" "2005-01-05" "2005-01-06"
#[7] "2005-01-07" "2005-01-08" "2005-01-09" "2005-01-10" "2005-01-11" "2005-01-12"
#[13] "2005-01-13" "2005-01-14" "2005-01-15" "2005-01-16" "2005-01-17" "2005-01-18"
#[19] "2005-01-19" "2005-01-20" "2005-01-21" "2005-01-22" "2005-01-23" "2005-01-24"
#[25] "2005-01-25" "2005-01-26" "2005-01-27" "2005-01-28" "2005-01-29" "2005-01-30"
#[31] "2005-01-31" "2005-02-01" "2005-02-02" "2005-02-03" "2005-02-04" "2005-02-05"
#[37] "2005-02-06" "2005-02-07" "2005-02-08" "2005-02-09" "2005-02-10" "2005-02-11"
#[43] "2005-02-12" "2005-02-13" "2005-02-14" "2005-02-15" "2005-02-16" "2005-02-17"
#[49] "2005-02-18" "2005-02-19" "2005-02-20" "2005-02-21" "2005-02-22" "2005-02-23"
#[55] "2005-02-24" "2005-02-25" "2005-02-26" "2005-02-27" "2005-02-28" "2005-03-01"
#  .
#  .
#  .
#[3643] "2014-12-22" "2014-12-23" "2014-12-24" "2014-12-25" "2014-12-26" "2014-12-27"
#[3649] "2014-12-28" "2014-12-29" "2014-12-30" "2014-12-31"