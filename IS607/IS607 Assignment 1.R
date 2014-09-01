#1. R 3.1.1 for windows, R Studio 0.98.1028 for Windows XP/Vista/7/8
#2. PostgreSQL 9.3.5.1 Win x86-64
#3. install DMwR, load data set sales, and determine number of observations
require(DMwR)
data()
sales
nrow(sales)