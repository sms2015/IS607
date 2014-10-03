#### Stacey Schwarcz ####
# week6quiz.R
# [For your convenience], here is the provided code from Jared Lander's R for Everyone, 
# 6.7 Extract Data from Web Sites

install.packages("XML")
require(XML)
theURL <- "http://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"
bowlPool <- readHTMLTable(theURL, which = 1, header = FALSE, stringsAsFactors = FALSE)
bowlPool

#### 1. ####
#What type of data structure is bowlpool? 
class(bowlPool)

#answer: bowlPool is a data.frame

#### 2. ####
#Suppose instead you call readHTMLTable() with just the URL argument,
# against the provided URL, as shown below

theURL <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL)
# What is the type of variable returned in hvalues?
hvalues
class(hvalues)

#answer: a list is returned

#### 3. ####
#Write R code that shows how many HTML tables are represented in hvalues
length(hvalues)

#output: 7
#There are 7 tables.

#### 4. ####
#Modify the readHTMLTable code so that just the table with Number, 
# FirstName, LastName, # and Points is returned into a dataframe
hvalues_table1 <- readHTMLTable(theURL,which=1, header=T,stringsAsFactors = F)
hvalues_table1

#output: 
#Number First   Name  Last Name Points
#1      1        Eve   Jackson     94
#2      2       John       Doe     80
#3      3       Adam   Johnson     67
#4      4       Jill     Smith     50

#### 5. ####
#Modify the returned data frame so only the Last Name and Points columns are shown.
table1_mod<-data.frame(c(hvalues_table1[3],hvalues_table1[4]))
table1_mod

#output:
#   Last.Name Points
#1   Jackson     94
#2       Doe     80
#3   Johnson     67
#4     Smith     50

#### 6 ####
#Identify another interesting page on the web with HTML table values.  
# This may be somewhat tricky, because while
# HTML tables are great for web-page scrapers, many HTML designers now prefer 
# creating tables using other methods (such as <div> tags or .png files).  

the_url2<-"http://www.petinsurancereview.com/dog.asp"

#### 7 ####
#How many HTML tables does that page contain?
pet_insurance<-readHTMLTable(the_url2)
length(pet_insurance)
#output: 71
#The page contains 71 HTML tables

#### 8 ####
#Identify your web browser, and describe (in one or two sentences) 
# how you view HTML page source in your web browser.

#Answer: Google Chrome: I right click somewhere on the page and select "View page source...".
