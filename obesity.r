#install.packages("ggplot2")
#install.packages("rvest")
install.packages("raster")
library(ggplot2)
library(rvest)
library(XML)
library(raster)


wiki <- read_html("https://en.wikipedia.org/wiki/Obesity_in_India")

#obs <- wiki %>% html_nodes("table") %>% .[[2]]%>% html_table(fill=T)

obs <- html_nodes(wiki,"table")
obs <- html_table(obs[[2]],fill=T)
str(obs)
class(obs)

names(obs)
nrow(obs)

names(obs) <- make.names(names(obs))
obs

states <- getData("GADM", country="India", level = 1)
str(states)
class(states)