#install and load necessary packages
library(tidyverse)
library(gtsummary)
library(easystats)
library(gt)
library(ggplot2)
library(naniar)
library(ggthemes)
library(RColorBrewer)
library(ggpubr)
library(likert)


#Import data
data <- readxl::read_xlsx("data/AMR_KAP_Data.xlsx",sheet = 1)
data2 <- readxl::read_xlsx("data/AMR_KAP_Data.xlsx",sheet = 2)

#Check missing values
gg_miss_var(data)


#Check Duplicated rows
sum(duplicated(data))


##Figure 2.   Attitude towards antibiotic resistance and the misuse of antibiotics
fig_data2 <- data|>
  select(24:33)

glimpse(fig_data2)

#Converting char. to factor 
Attitude_df <- fig_data2|>
  mutate_if(is.character , as.factor )|>
  as.data.frame()

glimpse(Attitude_df)

#Plot in likert scale
p21 <- plot(likert(Attitude_df),
            ordered = FALSE,
            group.order = names(Attitude_df),
            center= 2)
p21 <- p21 + theme_pubr() +
  ggtitle(" Figure 2.  Attitude towards antibiotic resistance and the misuse of antibiotics
  among parents of school-going children (N = 704).")


#Export Figure
ggsave("Figures/Figure2. Attitude_towards_antibiotic_resistance.png", 
       plot = p21, 
       width = 12, 
       height = 6, 
       dpi = 600)
