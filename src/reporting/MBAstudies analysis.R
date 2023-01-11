## Loading packages and data 
library(readr)
library(dplyr)
library(readr)

MBA <- read_csv("C:/Users/ambro/Desktop/Final odcm/MBAStudies_1924_03262022.csv") #add a path the csv output on your device
MBA2 = select(MBA, -13, -14) #delete the last two columns with error header (not needed)
View(MBA2)
summary(MBA2)

## 1: Transforming data
#Correcting classes
sapply(MBA2,class) #most of the columns' values are seen as characters, while they should be numeric. 

#Modifying column names
colnames(MBA2) <- c("id", "all_locations", "duration", "startdate", "deadline", "languages",
                    "study_type", "pace", "tuition_fees3", "url", 
                    "tuition_fees2", "tuition_fees1") 

#Explore summary statistics dataset
View(MBA2)
summary(MBA2)


#Find the programs are taught in English
sum(grepl("English", MBA2$languages))

#Find and list the programs across the countries
countries <- sapply(MBA2$all_locations, function(x){
  x <- unlist(strsplit(x, ","))
  trimws(x[length(x)])
})
countries <- as.vector(countries)
countries <- gsub("Online", "", countries)
countries <- trimws(countries)
table(countries)


#combine tuition fee**, tuition fee*, tuition fee
MBA2$tuition_fees1[MBA2$tuition_fees1=="Request Info"] <- NA
MBA2$tuition_fees2[MBA2$tuition_fees2=="Request Info"] <- NA
MBA2$tuition_fees3[MBA2$tuition_fees3=="Request Info"] <- NA
MBA2$tuitionfees <- MBA2$tuition_fees1
MBA2$tuitionfees[is.na(MBA2$tuitionfees)] <- MBA2$tuition_fees2[is.na(MBA2$tuitionfees)]
MBA2$tuitionfees[is.na(MBA2$tuitionfees)] <- MBA2$tuition_fees3[is.na(MBA2$tuitionfees)]


#make a table to list "start date" and "application deadline"
MBA2$startdate[MBA2$startdate=="Request Info"] <-NA
MBA2$deadline[MBA2$deadline=="Request Info"] <-NA
MBA2$deadline[MBA2$deadline=="Request Info*"] <-NA
MBA2$deadline[MBA2$deadline=="Contact school"] <-NA
MBA2$deadline[MBA2$deadline=="Contact school*"] <-NA
MBA2$startdate[MBA2$startdate=="Open Enrollment"] <-NA

table(MBA2$startdate)
table(MBA2$deadline)