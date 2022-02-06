#### Preamble ####
# Purpose: Clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander [CHANGE THIS TO YOUR NAME!!!!]
# Data: 3 January 2021
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!
# - Change these to yours
# Any other information needed?


#### Workspace setup ####
# Use R Projects, not setwd().
library(tidyverse)
library(opendatatoronto)
library(dplyr)

# get package
package <- show_package("0600cad8-d024-483b-a9a8-ecfc3e32e375")
package
# get resources
resources <- list_package_resources("0600cad8-d024-483b-a9a8-ecfc3e32e375")
#get the 2018 data from the resources
data = resources%>%
  filter(name=="annual-energy-consumption-data-2018")%>%
  get_resource()
#filter all NAs and slecet the needed variables
data<-data%>%
  filter(!is.na(...6)&!is.na(`Energy Consumption and Greenhouse Gas Emissions Reporting - for 2018`)&!is.na(...8)&!is.na(...10)&!is.na(...12)&!is.na(...32))%>%
  select(...6,`Energy Consumption and Greenhouse Gas Emissions Reporting - for 2018`,...8,...10,...12,...32,...36)
#construct a new data frame
annual_energy_comsump_2018<-data%>%
#rename and restore the selected columns
  mutate(area=as.numeric(data$...6))%>%
  mutate(operation_type=as.factor(data$...36))%>%
  mutate(average_hour=as.numeric(data$...8))%>%
  mutate(use_of_elec=as.numeric(data$...10))%>%
  mutate(use_of_gas=as.numeric(data$...12))%>%
  mutate(GHG=as.numeric(data$...32))%>%
#select the needed rows
  filter(operation_type=="Fire Stations"|operation_type=="Public Libraries"|operation_type=="Storage Facilities"|operation_type=="Administrative Offices"|operation_type=="Ambulance Stations"|operation_type=="Community Centres")%>%
  select(area,use_of_elec,use_of_gas,average_hour,GHG,operation_type)
#save the clean data as a csv file in inputs->data
write.csv(annual_energy_comsump_2018, "inputs/data/annual_energy_comsump_2018.csv")

         




         
         