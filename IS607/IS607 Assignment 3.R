#### Stacey Schwarcz,  Week 3 Assignment ####
#The answers to the following questions should be placed in a single R script. Place your 
#R script in a public repository on github and submitting a link to the script here. Label 
#your answers using comments so that they can be clearly and quickly found within the script.
#Week 3 assignment is due end of day on Tuesday September 16th. 

####1.####
#Write a function that takes a vector as input and returns the number of missing values in 
#the vector.
v<-c(1:5,NA,7:11,NA)
v
f.na<-function(v){
  sum(is.na(v))
}

f.na(v)
#output: 2

#### 2.####
# Write a function that takes a data frame as input and returns a named vector with the 
# number of missing values in each column of the data frame. (The names of the entries should
#be the corresponding column names of the data frame.) You may use the function from the 
#previous question as part of your solution.
DF<-data.frame(numbers=c(1,NA,3,NA,5),colors=c(NA,"Red","Blue","Green",NA),letters=c("a","b",NA,"d","e"))
DF
DF.NA<-function(DF){
  sapply(DF,function(x) f.na(x))
}

DF.NA(DF)
#output: 
#numbers  colors letters 
#     2       2       1 

####3.####
#Write a function that takes a numeric vector as input and uses it to determine the minimum,
#the maximum, the mean, the median, the first quartile, the third quartile, the standard 
#deviation of the vector, and the number of missing values. Do not use any built-in functions 
#to do this. Return a named list with the eight desired values in an order you deem best. 
#(You may, if you like, use the function you wrote for question 1.)
nv<-c(4:8,NA,1:5,NA,25:35,NA,NA)

medvf<-function(n,sortv){
  if (n%%2==0){
  medv<-(sortv[n/2]+sortv[n/2+1])/2
}else{
  medv<-sortv[(n+1)/2]
}
medv
}


f.stats<-function(v){
  newv<- na.omit(v) 
  
  n=length(newv)
  
  minv=newv[1]
  maxv=newv[1]
  for (i in 1:(n-1)){
    if (minv>newv[i+1]){
      minv<-newv[i+1]
    }
    if (maxv<newv[i+1]){
      maxv<-newv[i+1]
    }
  }
  
  meanv<-sum(newv)/n
  
  sortv=sort(newv,decreasing=FALSE)
  
  medv=medvf(n,sortv)  
  
  if (n%%2==0){
    lhalf<-sortv[1:n/2]
    hhalf<-sortv[(n/2+1):n]
  }else{
    lhalf<-sortv[1:((n+1)/2)-1]
    hhalf<-sortv[(((n+1)/2)+1):n]
  }
  Q1v<-medvf(length(lhalf),lhalf)
  Q3v<-medvf(length(hhalf),hhalf)
  
  sdv<-sqrt(sum((sortv-meanv)^2)/n)
  
  isna<-f.na(v)
  
  list("minimum"=minv,"maximum"=maxv,"mean"=meanv,"median"=medv,"first Quartile"=Q1v,"third quartile"=Q3v,"standard deviation"=sdv,"missing values"=isna)
}

f.stats(nv)

#output:
#$minimum
#[1] 1

#$maximum
#[1] 35

#$mean
#[1] 17.85714

#$median
#[1] 25

#$`first Quartile`
#[1] 4.5

#$`third quartile`
#[1] 30.5

#$`standard deviation`
#[1] 13.01752

#$`missing values`
#[1] 4


#### 4.####
#Write a function that takes a character or factor vector and determines the number of 
#distinct elements in the vector, the most commonly occurring element, the number of times 
#the most commonly occurring element occurs, and the number of missing values. (Be sure to 
#handle ties gracefully.) Have the function return a named list with the desired information
#in a logical order.
v<-c("a","b",NA,"b","c",NA,"c","a",NA,"b","c","d",NA,"e","a")

modef<-function(v){
  modet<-table(v)
  namet<-names(modet)
  d.elem<-length(modet)
  maxt<-max(modet)
  mostname<-character()
  for (i in 1:d.elem){
    if (modet[i]==maxt){
      mostname<-c(mostname,namet[i])
    }
  }
  mostname
  isna<-f.na(v)
  list("# of distinct elements"=d.elem,"# of missing values"=isna,"most common element(s)"=mostname,"# of times most common element(s) occur"=maxt)
}
modef(v)

#output
#$`# of distinct elements`
#[1] 5

#$`# of missing values`
#[1] 4

#$`most common element(s)`
#[1] "a" "b" "c"

#$`# of times most common element(s) occur`
#[1] 3

#### 5. ####
#Write a function that takes a logical vector and determines the number of true values, 
#the number of false values, the proportion of true values, and the number of missing values. 
#Have the function return a named list with the desired information in a logical order.

sprintf("%d and %d",2,4)
lv<-c(TRUE,FALSE,NA,TRUE,TRUE,NA,FALSE,NA,TRUE)

logic.f<-function(v){
  n=length(v)
  isna<-f.na(v)
  notna=n-isna
  tvalue<-sum(v,na.rm=TRUE)
  fvalue<-notna-tvalue
  propt<-sprintf("%d/%d",tvalue,notna)
  list("number of missing values"=isna,"# of true values"=tvalue,"proportion of true values to total values (excluding missing values)"=propt,"# of false values"=fvalue)
}
logic.f(lv)

#output:
#$`number of missing values`
#[1] 3

#$`# of true values`
#[1] 4

#$`proportion of true values to total values (excluding missing values)`
#[1] "6/10"

#$`# of false values`
#[1] 2



#### 6. ####
#Write a function that takes as its input a data frame and returns a summary of its columns 
#using the functions you write for questions 3-5. You may assume that all columns will be 
#of the three types in those questions. You are expected to use the functions you have written 
#in the previous questions, so you do not have to write them again by scratch. Return the 
#desired information in a format that you deem best. (One suggestion would be a named list of 
#lists, but I leave it to your judgment.)
nv2<-c(4:8,NA,1:5,NA,NA,NA,7)
v2<-c("a","b",NA,"b","c",NA,"c","a",NA,"b","c","d",NA,"e","a")
lv2<-c(TRUE,FALSE,NA,TRUE,TRUE,NA,FALSE,NA,TRUE,NA,NA,FALSE,TRUE,TRUE,FALSE)

DF2<-data.frame(numbers=nv,letters=v,logic=lv,stringsAsFactors=FALSE)
DF2



combinedf<-function(DF){
  a<-DF[[1]] 
  f.a<-f.stats(a)
  b<-DF[[2]] 
  f.b<-modef(b)
  c<-DF[[3]] 
  f.c<-logic.f(c)
  list("numeric"=f.a,"character"=f.b,"logical"=f.c)
}
combinedf(DF2)

#output:
#$numeric
#$numeric$minimum
#[1] 1

#$numeric$maximum
#[1] 8

#$numeric$mean
#[1] 4.727273

#$numeric$median
#[1] 5

#$numeric$`first Quartile`
#[1] 3

#$numeric$`third quartile`
#[1] 7

#$numeric$`standard deviation`
#[1] 2.092884

#$numeric$`missing values`
#[1] 4


#$character
#$character$`# of distinct elements`
#[1] 5

#$character$`# of missing values`
#[1] 4

#$character$`most common element(s)`
#[1] "a" "b" "c"

#$character$`# of times most common element(s) occur`
#[1] 3


#$logical
#$logical$`number of missing values`
#[1] 5

#$logical$`# of true values`
#[1] 6

#$logical$`proportion of true values (out of total values excluding missing values)`
#[1] "6/10"

#$logical$`# of false values`
#[1] 4
