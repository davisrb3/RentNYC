# Rent NYC - Analysis of apartment rental rates in NYC
# Author - Rob Davis
# Date - 9/8/2020

library(tidyverse)
library(shinydashboard)
library(devtools)
library(googleVis)
library(DT)
library(lubridate)

# Helper function to import one table + cleanup and format
import <- function(beds, report) {
  path = paste0("./data/", beds, "/", report, "_", beds, ".csv")
  df.in <- read.csv(path) %>%
    gather(., key = "Month", value = "value", -c(1:3), na.rm = TRUE) %>%
    mutate(., BR = beds, Month = ymd(paste0(substr(Month,2,100),".01")))
  return(df.in)
}

# Function to import all data tables and combine, reformat bedroom data
import_all <- function(report) {
  beds <- c("Studio", "OneBd", "TwoBd", "ThreePlusBd")
  out <- data.frame()
  for (br in beds) {
    temp <- import(br, report)
    out <- rbind(out, temp)
  }
  return(out)
}

# Split combined tables into lists of tables categorized by areaType
# some areaType rows (submarket, borough, city) are used for subtotaling and should only use "neighborhood" data for granularity
medRent.raw <- import_all("medianAskingRent")
disc.raw <- import_all("discountShare")
inv.raw <- import_all("rentalInventory")

medRent.list <- split(medRent.raw, medRent.raw$areaType)
disc.list <- split(disc.raw, disc.raw$areaType)
inv.list <- split(inv.raw, inv.raw$areaType)

# Declare neighborhood df's
med <- medRent.list$neighborhood
disc <- disc.list$neighborhood
inv <- inv.list$neighborhood

# Calculate "per room" values and add to med
perRoom <- function(x) {
  pr <- x %>%
    spread(., key = "BR", value = "value") %>%
    arrange(., Month, Borough, areaName) %>% 
    mutate(.,
           add1 = OneBd - Studio,
           add2 = TwoBd - OneBd,
           add3p = ThreePlusBd - TwoBd) %>% 
    select(., Month, "Neighborhood" = areaName, Borough, 
           Studio, OneBd, TwoBd, ThreePlusBd, 
           "BdOne" = add1, "BdTwo" = add2, "BdThreePlus" = add3p) %>% 
    gather(., key = Rooms, value = medRent, -c(1:3), na.rm = T)
  return(pr)
}

roomGroup <- function(x){
  rent <- x %>% filter(., Rooms %in% c("Studio", "OneBd", "TwoBd", "ThreePlusBd"))
  room <- x %>% filter(., Rooms %in% c("BdOne", "BdTwo", "BdThreePlus")) %>% 
    mutate(.,
           Rooms = recode(Rooms, 
                        "BdOne" = "OneBd", 
                        "BdTwo" = "TwoBd", 
                        "BdThreePlus" = "ThreePlusBd"), 
           addRent = medRent) %>% 
    select(., -medRent)
  
  out <- left_join(rent, room)
  
  return(out)
}

med.pr <- perRoom(med)

# Create variable of boroughs
boroList <- unique(arrange(med.pr,Borough)[,"Borough"])
#nhList <- unique(arrange(med.pr,Neighborhood)[,"Neighborhood"])
roomList <- c("Studio", "1BR", "2BR", "3BR+")

# Create plot of per room rent rates over time which can be filtered by boro, scope, and time range
rentTrend <- function(input, boro, nh, output){
  byBoro <- input %>% 
    filter(., Borough==boro, 
           Neighborhood %in% nh,
           )
  return(byBoro)    
}

# boroTrend <- rentTrend(med.pr, "Queens", c("Astoria", "Forest Hills"),0) %>% 
#   mutate(., 
#          quarter = yq(quarter(Month, with_year = T)), 
#          year = year(Month)) %>% 
#   group_by(., year, Neighborhood) %>% 
#   summarise(., OneBd = mean(OneBd), na.rm = TRUE)
# head(boroTrend)

# ggplot(boroTrend, mapping = aes(x = year, y = OneBd)) + 
#   geom_point(aes(color = Neighborhood)) +
#   geom_smooth(aes(color = Neighborhood), method = "lm", se = F) + 
#   geom_line(aes(color = Neighborhood))





