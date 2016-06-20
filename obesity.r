#install.packages("ggplot2")
#install.packages("rvest")
#install.packages("raster")
#install.packages("sqldf")
install.packages("mapproj")
library(ggplot2)
library(rvest)
library(XML)
library(raster)
library(sqldf)
library(mapproj)


wiki <- read_html("https://en.wikipedia.org/wiki/Obesity_in_India")

#obs <- wiki %>% html_nodes("table") %>% .[[2]]%>% html_table(fill=T)

obs <- html_nodes(wiki,"table")
obs <- html_table(obs[[2]],fill=T)

names(obs) <- make.names(names(obs))
obs <- obs[obs$States!="India",]
states <- getData("GADM", country="India", level = 1)
states_df <- data.frame(states)

obs$NAME_1 <- obs$States
temp_st <- map_data(states)
names(states)[6] <- "NAME_1"
names(states)[5] <- "region"
names(obs)[1] <- "region"


st <- sqldf("select * from temp_st join states_df using(region)")
st$region <- st$NAME_1

st <- st[,1:5]
data1 <- merge(st,obs)

g <- ggplot(data1,aes(x=long,y=lat,group=group, fill=(data1$Males....+data1$Females....)/2)) + geom_polygon(color="white")
g <- g + scale_fill_gradient(name="Percent", low= "#feceda", high= "#c81f49", guide="colorbar", na.value = "black", breaks=pretty(x=5))
g <- g + coord_map()