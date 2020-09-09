# Rent NYC - Analysis of apartment rental rates in NYC
# Author - Rob Davis
# Date - 9/8/2020
# Data analysis

library(tidyverse)
library(lubridate)

# Create combined tables from source files

# Helper function to import one table
import <- function(beds, report){
  
  path = paste0("../data/", beds, "/", report, "_", beds, ".csv")
  
  df.in <- read.csv(path) %>%
    gather(., key = "Month", value = "value",-c(1:3), na.rm=TRUE) %>%
    mutate(., BR = beds, Month = gsub("\\.", "-", gsub("X", "", Month)))

  return(df.in)  
}


# function to import group of tables and compile
import_all <- function(report){
  
  beds <- c("Studio","OneBd","TwoBd","ThreePlusBd")
  
  out <- data.frame()
  
  for (br in beds){
    temp <- import(br,report)
    out <- rbind(out,temp)
  }
  return(out)
}

medRent.raw <- import_all("medianAskingRent")
disc.raw <- import_all("discountShare")
inv.raw <- import_all("rentalInventory")

medRent <- filter(med)



