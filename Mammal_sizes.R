### Final Assignment

mammal_sizes<-read.csv("MOMv3.3.txt",sep="\t", head=FALSE, stringsAsFactors = FALSE, na.strings="-999")

# To add column names 

colnames(mammal_sizes) <- c("continent", "status", "order", 
          "family", "genus", "species", "log_mass", "combined_mass", 
                            "reference")
