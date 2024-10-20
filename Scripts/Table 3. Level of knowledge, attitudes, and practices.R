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



#Table 3.  Level of knowledge, attitudes, and practices
data2 <- data2|>    #making new column
  mutate(Knowledge_level = case_when(
    Knowledge_PCT < 25 ~ "Poor",
    Knowledge_PCT <= 50 ~ "Moderate",
    Knowledge_PCT >= 50 ~ "Good",
  )) |>
  mutate(Attitude_level = case_when(
    Attitude_PCT < 25 ~ "Negative",
    Attitude_PCT <= 50 ~ "Uncertain",
    Attitude_PCT >= 50 ~ "Positive"
  )) |>
  mutate(Practice_level = case_when(
    Practice_PCT <75 ~  "Misuse",
    Practice_PCT >= 75 ~  "Good"
  )) |>   #making table
  select(69:71)|>
  tbl_summary() |>
  as_gt()|>
  gtsave("Tables/Table3_Level_of_knowledge,_attitudes,_and_practices.docx")