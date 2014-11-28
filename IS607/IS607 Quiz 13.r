#generate 1,000,0000 random numbers
#n <- sample(1:100, 1000000, replace=T)
n <- 1:100000000
system.time(for (i in n) i^3) / length(n)

#output:
#user       system    elapsed 
#2.739e-07 0.000e+00 2.742e-07 

library(Rcpp)

cppFunction('int cube(int x) {
  int cube = x*x*x;
  return cube;
}')

#test cube function
cube(3)

system.time(for (i in n) cube(i)) / length(n)
#output:
#user         system    elapsed 
#1.1742e-06 0.0000e+00 1.1750e-06 


