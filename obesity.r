#install.packages("ggplot2")
#install.packages("rvest")

library(ggplot2)
library(rvest)

wiki <- read_html("https://en.wikipedia.org/wiki/Obesity_in_India")

obs <- wiki %>% html_nodes("table") %>% .[[1]]%>% html_table(fill=T)
