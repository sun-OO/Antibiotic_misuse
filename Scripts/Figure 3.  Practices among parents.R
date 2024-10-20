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



## Figure 3.  Practices among parents
fig_data3 <- data|>
  select(34:39)



glimpse(fig_data3)

#Converting char. to factor 
Practice_df <- fig_data3|>
  mutate_if(is.character , as.factor )|>
  as.data.frame()

glimpse(Practice_df)

#Plot in likert scale
p31 <- plot(likert(Practice_df),
            ordered = FALSE,
            group.order = names(Practice_df),
            center= 1.5)
p31 <- p31 + theme_pubr() +
  ggtitle(" Figure 3.  Practices among parents of school-going children 
          regarding antibiotic resistance (N = 704).")


#Export Figure
ggsave("Figures/Figure 3.Practices_among_parents.png", 
       plot = p31, 
       width = 12, 
       height = 6, 
       dpi = 600)
