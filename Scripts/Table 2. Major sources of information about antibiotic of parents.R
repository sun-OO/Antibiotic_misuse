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





#Table 2. Major sources of information about antibiotic of parents
data2 |>
  select(41:49)|>
  tbl_summary() |>
  as_gt()|>
  gtsave("Tables/Table2_ Major_sources_of_information_about_antibiotic_of_parents.docx")