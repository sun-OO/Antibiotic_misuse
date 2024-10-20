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
  ))



# Table 6.  Factors associated with the level of practices
#Convert outcome into factor
data2$Practice_level  <- as.factor(data2$Practice_level)

#Building table
T6_reg <- data2 |> 
  select(1:9, Practice_level) |>
  tbl_uvregression(
    method = glm,
    y = Practice_level,
    method.args = list(family = binomial),
    exponentiate = T
  )|>
  bold_p(t=0.05)|>
  as_gt()

gtsave(T6_reg, "Tables/Table_6_UV_LogReg_Practice_level.docx")


