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

mean_mass <- summarize(by_status, avg_mass = mean(combined_mass, na.rm=TRUE)); mean_mass

# 3. Compare the mean masses within each of the different continents 

unique(mammal_sizes$continent) 

select(mammal_sizes, status, combined_mass, continent) # first selec the colums we are interested 
filter_to_extant_extinct<-filter(mammal_sizes, status=="extant"| status=="extinct")
unique(filter_to_extant_extinct$status) 
by_continent<-group_by(filter_to_extant_extinct,continent, status)
mean_mass_continent <- summarize(by_continent, avg_mass = mean(combined_mass, na.rm=TRUE)); mean_mass_continent

library(tidyr)
library(dplyr)
library(ggplot2)

mass_diff_continents <- mean_mass_continent %>%
 spread(status, avg_mass)%>%
filter(continent!="Af")
tidier %>% head(7)

write.table(mass_diff_continents, "continent_mass_differences.csv") # Use sep = ",",  if you want an organized table in columns when opening in excel

# 4. Plot: Formatting the data to be plotted

filter_status<-filter(mammal_sizes, status =="extant" | status =="extinct")  ; head(filter_status) ; unique(filter_status$status)  # Review the selected columns
by_status<-group_by(filter_status,status)
status_logmass_cont <- select(by_status, continent, log_mass, status) ; status_logmass_continent
filter2<-filter(status_logmass_cont, log_mass != "NA")  # to remove the "Af"
# table(filter2$continent,filter2$status)  # to check if I removed the NAs in Af
extinct_extanct_continent<-filter(filter2, continent != "EA" & continent != "Oceanic")
# table(extinct_extanct_continent$continent,extinct_extanct_continent$status)   # Used to check the data

# Plot

png("extinct_extanct_graph.png")
qplot(log_mass, data=extinct_extanct_continent, geom = "histogram", binwidth = 1/6)+
  xlim(c(0,8))+
  facet_grid(continent~status)+
  xlab("Log (Mass)")+
  ylab("No. Species")+
  ggtitle("Number of extant and extinct species per continent")
dev.off()


