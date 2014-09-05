#### Stacey Schwarcz,  Week 2 Quiz ####

#### 1.####
#Create a vector that contains 20 numbers. (You may choose whatever 
#numbers you like, but make sure there are some duplicates.)
my20vector<-c(5,4,8,9,5,6,2,3,8,4,6,7,2,3,5,7,3,1,4,6)
# output: 5 4 8 9 5 6 2 3 8 4 6 7 2 3 5 7 3 1 4 6

#### 2.####
#Use R to convert the vector from question 1 into a character vector.
as.character(my20vector)
#output: "5" "4" "8" "9" "5" "6" "2" "3" "8" "4" "6" "7" "2" "3" "5" "7" "3" "1" "4" "6"

#### 3. ####
#Use R to convert the vector from question 1 into a vector of factors.
factormy20vector=as.factor(my20vector)
factormy20vector
#output: 5 4 8 9 5 6 2 3 8 4 6 7 2 3 5 7 3 1 4 6
#        Levels: 1 2 3 4 5 6 7 8 9

#### 4. ####
#Use R to show how many levels the vector in the previous question has.
levels(factormy20vector)
#output: "1" "2" "3" "4" "5" "6" "7" "8" "9"

#### 5.####
#Use R to create a vector that takes the vector from question 1 and performs
# on it the formula 3X^2 − 4X + 1.
as.numeric(my20vector)
my_calc_vector=3*my20vector^2-4*my20vector+1
my_calc_vector
#output: 56  33 161 208  56  85   5  16 161  33  85 120   5  16  56 120  16   0  33  85

#### 6.####
# Implement ordinary least-squares regression in matrix form: Beta = (X^TX)^−1X^Ty. 
# As a useful double check you should be able to run your regression on the matrices 
# X and y to get Beta below:
X<-matrix(c(1,1,1,1,1,1,1,1,5,4,6,2,3,2,7,8,8,9,4,7,4,9,6,4),nrow=8)
y<-matrix(c(45.2,46.9,31.0,35.3,25.0,43.1,41.0,35.1),nrow=8)
Beta=solve(t(X)%*%X)%*%t(X)%*%y
Beta
# Output: 
#         [,1]
#[1,] 3.153126
#[2,] 1.983743
#[3,] 3.999539

#### 7. ####
#Create a named list. That is, create a list with several elements that are each 
# able to be referenced by name.
named_list<-list(first="apple",second="orange",third="grape",fourth="cherry")
named_list
#Output:
#$first
#[1] "apple"
#
#$second
#[1] "orange"
#
#$third
#[1] "grape"
#
#$fourth
#[1] "cherry"


#### 8. ####
#Create a data frame with four columns – one each character, factor 
# (with three levels), numeric, and date. Your data frame should have at least 10 
# observations (rows).
a<-as.character(-4:5)
b<-as.factor(c(3,2,3,1,2,3,1,2,3,1))
c<-as.numeric(1:10)
d<-as.Date(c("2011-11-15","2011-11-28","2012-06-08","2012-07-21","2013-04-05",
             "2014-03-06","2014-05-15","2014-06-25","2014-08-10","2014-09-01"))
myDF<-data.frame(a,b,c,d)
myDF
#output:
#a   b c          d
#1  -4 3  1 2011-11-15
#2  -3 2  2 2011-11-28
#3  -2 3  3 2012-06-08
#4  -1 1  4 2012-07-21
#5   0 2  5 2013-04-05
#6   1 3  6 2014-03-06
#7   2 1  7 2014-05-15
#8   3 2  8 2014-06-25
#9   4 3  9 2014-08-10
#10  5 1 10 2014-09-01

#### 9. #### 
#Illustrate how to add a row with a value for the factor column that isn’t already 
# in the list of levels. (Note: You do not need to accomplish this with a single line of code.)
newFactor<-factor(c(1,2,3,4))
newFactor
model.matrix(~newFactor-1)
#output:
#newFactor1 newFactor2 newFactor3 newFactor4
#1          1          0          0          0
#2          0          1          0          0
#3          0          0          1          0
#4          0          0          0          1
#attr(,"assign")
#[1] 1 1 1 1
#attr(,"contrasts")
#attr(,"contrasts")$newFactor
#[1] "contr.treatment"

#### 10. ####
#Show the code that would read in a CSV file called temperatures.csv from the current 
# working directory.
temperatures<-read.csv("temperatures.csv")

#### 11. ####
#Show the code that would read in a TSV file called measurements.txt from a directory 
# other than the working directory on your local machine.
measurements<-read.csv("c:/path_on_local_machine..../measurements.txt", sep="\t")

#### 12. ####
#Show the code that will read in a delimited file with a pipe separator (the “|” symbol) 
# from a website location. (You may make up an appropriate URL.)
pipedelimfile<-read.table("http://homepages.wmich.edu/~m3schul1/pipetest.psv",header=FALSE ,sep="|")

#### 13. ####
#Write a loop that calculates 12-factorial.
y<-1
for (i in 1:12)
  {
  y<-y*((1:12)[i])
}
print(y)
#output: 479001600

#### 14. #### 
#Use a loop to calculate the final balance, rounded to the nearest cent, in an account 
# that earns 3.24% interest compounded monthly after six years if the original balance is $1,500.
balance= 1500
rate=0.0324/12
for (i in 1:6)
{
  for (j in 1:12)
  {
    balance=balance*(1+rate)
  }
  
}
sprintf("$ %.2f",balance)
#output: $ 1821.40

#### 15. ####
#Create a numeric vector of length 20 and then write code to calculate the sum of every 
#third element of the vector you have created.
new20vector<-(-9:10)
sum(new20vector[c(3,6,9,12,15,18)])
#output: 3

#### 16. ####
#Use a for loop to calculate sum of i=1 to 10 for x^i for the value X = 2.
sumloop=0
x=2
for (i in 1:10)
{
  sumloop=sumloop+x^i
}
print(sumloop)
#output: 2046

#### 17. ####
#Use a while loop to accomplish the same task as in the previous exercise.
sumloop=0
i=1
x=2
while (i<=10)
{
  sumloop=sumloop+x^i
  i=i+1
}
print(sumloop)
#output: 2046

#### 18. ####
#Solve the problem from the previous two exercises without using a loop.
sum(2^(1:10))
#output: 2046

#### 19. ####
#Show how to create a numeric vector that contains the sequence from 20 to 50 by 5.
seq(20,50,5)
#output: 20 25 30 35 40 45 50

#### 20. ####
#Show how to create a character vector of length 10 with the same word, “example”, ten times.
charvector<-rep("example",10)
charvector


#### 21. ####
#Show how to take a trio of input numbers a, b, and c and implement the quadratic equation.
a<-1
b<-2
c<-1
x1<-(-b+sqrt(b^2-4*a*c))/(2*a)
x2<-(-b-sqrt(b^2-4*a*c))/(2*a)
x1
x2
#output:  x1=-1, x2=-1
