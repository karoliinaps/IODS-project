
#Karoliina Pilli-Sihvola
#22.11.2017
#This is the R script for data wrangling of student-mat.csv and student-por.csv files from UCI Machine Learning Repository , Student Performance Data 
#(incl. Alcohol consumption)



math <- read.csv("student-mat.csv", sep=";", header=T)
por <- read.csv("student-por.csv", sep=";", header=T)

dim(math)
dim(por)

str(math)
str(por)


library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

#Keeping only the students present in both data sets
math_por <- inner_join(math, por, by = join_by, suffix=c(".math", ".por")) 

dim(math_por)
str(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

#the average of the answers related to weekday and weekend alcohol consumption:

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#'high_use'  is TRUE for students for which 'alc_use' is greater than 2
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)
write.csv(alc, file="alc.csv", row.names=FALSE)
