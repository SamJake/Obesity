#install.packages("ggplot2")
#install.packages("rvest")

library(ggplot2)
library(rvest)
library(XML)

wiki <- read_html("https://en.wikipedia.org/wiki/Obesity_in_India")

#obs <- wiki %>% html_nodes("table") %>% .[[2]]%>% html_table(fill=T)

obs <- html_nodes(wiki,"table")
obs <- html_table(obs[[2]],fill=T)
