### Final Assignment

mammal_sizes<-read.csv("MOMv3.3.txt",sep="\t", head=FALSE, stringsAsFactors = FALSE, na.strings="-999")

# To add column names 

colnames(mammal_sizes) <- c("continent", "status", "order", 
          "family", "genus", "species", "log_mass", "combined_mass", 
                            "reference")

# 2. Calculate the mean mass of the extinct species and the mean mass of the 
# extant species.

library("dplyr")

unique(mammal_sizes$status) # to get the name of diferent clases withing a specific column
# in this case status.

select(mammal_sizes, status, combined_mass) # first selec the colums we are interested 

filter_to_extant_extinct<-filter(mammal_sizes, status=="extant"| status=="extinct") # we use filter to
# select only calsses extinct and extant 

unique(filter_to_extant_extinct$status) 

by_status<-group_by(filter_to_extant_extinct,status)

mean_mass <- summarize(by_status, avg_mass_extint = mean(combined_mass, na.rm=TRUE)); mean_mass




