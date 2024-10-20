#install and load necessary packages
library(tidyverse)
library(gtsummary)
library(easystats)
library(gt)
library(ggplot2)
library(naniar)


#Import data
data <- readxl::read_xlsx("data/AMR_KAP_Data.xlsx",sheet = 1)
data2 <- readxl::read_xlsx("data/AMR_KAP_Data.xlsx",sheet = 2)

#Check missing values
gg_miss_var(data)


#Check Duplicated rows
sum(duplicated(data))


#Table 1. Demographic characteristics of study participants
data2 |>
  select(1:11)|>
  tbl_summary() |>
  as_gt()|>
  gtsave("Tables/Table1_Demographic_info.docx")



