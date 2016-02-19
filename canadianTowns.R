library(rvest)
library(XML)

#sub function
subx4y<-function(matrix,x=x,y=y){
  for(i in 1:length(x)){
    matrix[,1]<-gsub(x[i],y[i],matrix[,1])
  }
  return(matrix)
}

#get table
url<-"https://en.wikipedia.org/wiki/List_of_the_100_largest_population_centres_in_Canada"
towns<-url%>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/table[1]') %>%
  html_table()
towns<-towns[[1]][,2]

#define substitutes
x<-c("�???"","è","â","é","ô")
y<-c("-","e","a","e","o")

#clean
towns %>%
  strsplit(",") %>%
  unlist() %>%
  matrix(nrow=100,ncol=2,byrow=T) %>%
  subx4y(x=x,y=y)->towns
  
#done - data stored in towns