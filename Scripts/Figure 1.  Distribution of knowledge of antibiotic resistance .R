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


# Figure 1.  Distribution of knowledge of antibiotic resistance 
fig_data1 <- data|>
  select(12:23)

glimpse(fig_data1)

#Converting char. to factor 
Knowledge_df <- fig_data1|>
  mutate_if(is.character , as.factor )|>
  as.data.frame()

glimpse(Knowledge_df)

#Plot in likert scale
p11 <- plot(likert(Knowledge_df),
            ordered = FALSE,
            group.order = names(Knowledge_df),
            center= 2)
p11<- p11 + theme_pubr() +
  ggtitle(" Figure 1.  Distribution of knowledge of antibiotic resistance
           among parents of school-going children (N = 704).")

#Export Figure
ggsave("Figures/Figure1.antibiotic_resistance_knowledge.png", 
       plot = p11, 
       width = 12, 
       height = 6, 
       dpi = 600)


