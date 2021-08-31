install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")

library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")


dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')

db <- dbGetQuery(MyDataBase, "select * from CountryLanguage")

names(db)

new <- db %>% filter(Language == "Spanish")
new.df <- as.data.frame(new)

new.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()
