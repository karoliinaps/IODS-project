#NAME = Karoliina Pilli-Sihvola
#DATE = 9.11.2017
#This script is for week 2 exercice.


  #Data wrangling

#Bring data

learn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)


# See what it looks like
str(learn14)
names(learn14)
#the dataframe has 183 observations of 60 variables. 
#[1] "Aa"       "Ab"       "Ac"       "Ad"       "Ae"       "Af"       "ST01"     "SU02"     "D03"      "ST04"    
#[11] "SU05"     "D06"      "D07"      "SU08"     "ST09"     "SU10"     "D11"      "ST12"     "SU13"     "D14"     
#[21] "D15"      "SU16"     "ST17"     "SU18"     "D19"      "ST20"     "SU21"     "D22"      "D23"      "SU24"    
#[31] "ST25"     "SU26"     "D27"      "ST28"     "SU29"     "D30"      "D31"      "SU32"     "Ca"       "Cb"      
#[41] "Cc"       "Cd"       "Ce"       "Cf"       "Cg"       "Ch"       "Da"       "Db"       "Dc"       "Dd"      
#[51] "De"       "Df"       "Dg"       "Dh"       "Di"       "Dj"       "Age"      "Attitude" "Points"   "gender"  

dim(learn14)

### create analysis dataset

install.packages("dplyr")
library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(learn14, one_of(deep_questions))
learn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(learn14, one_of(surface_questions))
learn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(learn14, one_of(strategic_questions))
learn14$stra <- rowMeans(strategic_columns)

str(learn14)
learn14_df <- subset(learn14, Points > 0, select=c(gender, Age, Attitude, deep, stra, surf, Points))

dim(learn14_df)
head(learn14_df)
  

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

setwd("~/05 LEARNING/MOOC HYMY/IODS-project/data")

write.csv(learn14_df, file="learning2014.csv", row.names=FALSE)

head(read.csv("learning2014.csv"))
