#install and load necessary packages
library(tidyverse)
library(gtsummary)
library(easystats)
library(gt)
library(ggplot2)
library(naniar)
library(MASS)

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



#Table 5.  Factors associated with the level of attitudes towards antibiotic resistance 
#Convert outcome into factor
data2$Attitude_level  <- as.factor(data2$Attitude_level)



A_model <- polr(Attitude_level ~  `Parent’s age (years)` +                        
                  `Parent’s sex`+                                
                  `Parent’s education level`  +                  
                  `Employment status` +                          
                  `Family type`    +                              
                  `Your average household income per month (BDT)`+
                  `Child’s sex` +                                
                  `Child’s age (years)`+                        
                  `Number of children`,
                data = data2 , Hess=T)


T5_reg <- A_model |>
  tbl_regression(
    exponentiate = TRUE  
  ) |>
  add_global_p() |>
  bold_p(t = 0.05) |>
  bold_labels() |>
  as_gt()


gtsave(T5_reg, "Tables/Table_5_UV_LogReg_Attitude_level.docx")