# 📦 PACKAGES ----
library(tidyverse) # a range of helpful packages
library(janitor)# helps to format the data



#💾 IMPORTING DATA ----

setwd("~/GitHub/great_tits/data")# setting the working directory

data_2021<-read.csv(file = "NestRecordsMadingley2021.csv", header = TRUE)
glimpse(data_2021)

#🧽 CLEANING DATA ---- 

nest_2021<-data_2021%>%
  select(site , boxNumber, site.boxNumber, Species, Antenna.PIT.tag.ID.1, Antenna.Pit.tag.ID.2,BTO.ring.derived.from.Antenna.ID.1, BTO.ring.derived.from.Antenna.ID.2, Female.Ring.number.from.trapping, Male.ring.number.from.trapping, numberFledged)# making a new df
#there is no data for male and female will find later 
head(nest_2021)#checking the first 6 lines 

nest_2021<- janitor::clean_names(nest_2021)# cleaning column names, snake_case
#nest_2019<- nest_2019 %>% mutate_all(na_if,"")#making all of the blanks into NA's

nest_2021<-cbind(nest_2021, year='2021') #add a new column named "year" with information about what year it comes from 
names(nest_2021) #checking the headings 
head(nest_2021)#checking the first 6 lines 

nest_2021_grt<-nest_2021%>%
  filter(species=="GRETI") #filter out blue_tit 

nest_2020_grt%>% 
  is.na() %>% 
  sum()#25 NA's removed ??   

write.csv(nest_2021_grt,file="nest_id_from_2021.csv")

PITIDM_2021<-unique(nest_2021_grt$pit_idm)# not sure what this does 
PITIDM_2021<-as.data.frame(PITIDM_2021)# not sure what this does 

# see in the nest box, how many different tags there are 
# need to know the ref tag 

# 🎰 Merge all 3 data frames ----

setwd("~/GitHub/great_tits/scripts")# setting the working directory

source("~/GitHub/great_tits/scripts/Cleaning_01_2019.R")
source("~/GitHub/great_tits/scripts/Cleaning_02_2020.R")

# merge two data frames by ID  stuck ----- 
total <- merge(data "nest_2021_grt",data "nest_2019_grt",data "nest_2020_grt", by="pit_idm")

joined_df <- merge(nest_2019_grt, nest_2020_grt, by.x = "antenna_pit_id_1", 
                   by.y = "antenna_pit_id_1", all.x = TRUE, all.y = FALSE)

