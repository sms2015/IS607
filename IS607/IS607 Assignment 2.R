# Week 2 Assignment - Exercises
# 1. Suppose that you have five customers – James, Mary, Steve, Alex, and Patricia – in line at a store. 
#Use R operations to perform the following tasks in sequence.

####   1a. ####
#Assign the five individuals to a vector called queue.
queue<-c("James","Mary","Steve","Alex","Patricia")
queue
#output: "James"    "Mary"     "Steve"    "Alex"     "Patricia"

####   1b. ####
#Update the queue for the arrival of a new patron named Harold.
queue<-c(queue,"Harold")
queue
#output:  "James"    "Mary"     "Steve"    "Alex"     "Patricia" "Harold"  

####   1c. ####
#Update the queue to reflect the fact that James has finished checking out.
remove=queue[1]
remove
queue<-setdiff(queue, remove)
queue
#output:  "Mary"     "Steve"    "Alex"     "Patricia" "Harold"  

####  1d. ####
#Update the queue to reflect the fact that Pam has talked her way in front of Steve with just one item.
queue<-c(queue[1],"Pam",queue[2:5])
queue
#output: "Mary"     "Pam"      "Steve"    "Alex"     "Patricia" "Harold"  

####   1e. ####
#Update the queue to reflect the fact that Harold has grown impatient and left.
remove2<-queue[6]
queue<-setdiff(queue, remove2)
queue
#output: "Mary"     "Pam"      "Steve"    "Alex"     "Patricia"

####   1f. ####
#Update the queue to reflect the fact that Alex has grown impatient and left. 
#(Do this as if you do not know what slot Alex currently occupies by number.)
alex.pos<-match("Alex",queue)
remove3<-queue[alex.pos]
queue<-setdiff(queue, remove3)
queue
#output:  "Mary"     "Pam"      "Steve"    "Patricia"

####   1g. ####
#Identify the position of Patricia in the queue.
patricia.pos<-match("Patricia",queue)
patricia.pos
#output: 4

####   1h. ####
#Count the number of people in the queue.
length(queue)
#output: 4

####2. ####
#Modify your answer to quiz exercise 21 so that when you implement the quadratic equation, meaningful output 
#is given whether there are one, two, or no solutions. (Hint: Use the discriminant.)
a<-1
b<-2
c<-1
disc<-b^2-4*a*c
disc
if(disc<0){
  roots<-"no solution"
}else {
  if(disc==0){
    roots<--b/(2*a)
  }else {
    roots<-c((-b+disc)/(2*a),(-b-disc)/(2*a))    
  }
  
}
roots
#solution (1 root): a=1,b=2,c=1  roots= -1
#solution (2 roots): a=5,b=25,c=5 roots= 50 and -55
#solution (no roots): a=5, b=8, c=5  roots= "no solution"

#### 3. ####
#Use R to determine how many numbers from 1 to 1000 are not 
#divisible by any of 3,7, and 11.
v=1:1000
#determine which have remainders and create logical vectors, TRUE means not divisible
v3=v%%3>0 
v7=v%%7>0 
v11=v%%11>0
#add the logical vectors together
v3711<-v3+v7+v11
#check the number of times each count appears, a count of 3 means three "TRUE" values
#meaning that the number is not divisible by any of 3,7, or 11
table(v3711)
#solution: there are 520 numbers between 1 and 1000 that are not divisible by 
#any of 3,7, and 11 (this is represented in the table under the 3 heading)
#output:
#v3711
#0   1   2   3 
#4  77 399 520 

#### 4. #### 
#Write R code that takes three input constants f, g, and h and determines whether they form 
#a Pythagorean Triple (such that the square of the largest input is equal to the sum of the 
#squares of the other two constants).
f<-5
g<-4
h<-3
inputs<-c(f,g,h)
inputs=sort(inputs)
pyth=inputs[1]^2+inputs[2]^2
ifelse(pyth==inputs[3]^2,"Is a Triple","Not a Triple")
#solution: f=5,g=4,h=3  "Is a Triple"
#solution: f=3,g=5,h=4  "Is a Triple"
#solution: f=6,g=10,h=2  "Not a Triple"
