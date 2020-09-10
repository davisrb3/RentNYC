# Rent NYC - Analysis of apartment rental rates in NYC
# Author - Rob Davis
# Date - 9/8/2020
# Data analysis
library(tidyverse)
library(lubridate)

# Create combined tables from source files

# Helper function to import one table + cleanup and format
import <- function(beds, report) {
  path = paste0("../data/", beds, "/", report, "_", beds, ".csv")
  df.in <- read.csv(path) %>%
    gather(.,
           key = "Month",
           value = "value",
           -c(1:3),
           na.rm = TRUE) %>%
    mutate(., BR = beds, Month = gsub("\\.", "-", gsub("X", "", Month)))
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

head(med)

# Calculate "per room" values and add to med
perRoom <- function(x) {
  pr <- x %>%
    spread(., key = "BR", value = "value") %>%
    mutate(.,
      "add1" = OneBd - Studio,
      "add2" = TwoBd - OneBd,
      "add3p" = ThreePlusBd - TwoBd)
  return(pr)
}
# Create plot of per room rent rates over time which can be filtered by boro, scope, and time range

Line4 <-  gvisLineChart(med, "Month", c("Studio","OneBd"),
                        options=list(gvis.editor="Edit me!"))

plot(Line4)

ggplot(med, mapping = aes(x= Month, y = ))





