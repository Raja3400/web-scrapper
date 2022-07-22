#install.packages("rvest")
#install.packages("dplyr")

library(rvest)

library(dplyr)

movies= data.frame()

for(page_result in seq(from=1,to =151, by =50))

{
  link= paste0("https://www.imdb.com/search/title/?title_type=feature&num_votes=10000,&sort=boxoffice_gross_us,desc&start=",page_result,"&ref_=adv_nxt")
  
  page = read_html(link)
  
  name = page %>% html_nodes(".lister-item-header a") %>% html_text()
 
  movie_links = page %>% html_nodes(".lister-item-header a") %>% html_attr("href") %>% paste("https://www.imdb.com",.,sep = "")
  
  year = page %>% html_nodes(".text-muted.unbold") %>% html_text()
  
  synopsis = page %>% html_nodes(".ratings-bar+ .text-muted") %>% html_text()
 
   rating = page %>% html_nodes(".ratings-imdb-rating strong") %>% html_text()
  
  director_stars= page %>% html_nodes(".text-muted+ p") %>% html_text()
  
  votes= page %>% html_nodes(".sort-num_votes-visible span:nth-child(2)") %>% html_text()
 
  score=  page %>% html_nodes(".ratings-metascore") %>% html_text()
  
  runtime = page %>% html_nodes(".runtime") %>% html_text()
  
  collection= page %>% html_nodes(".ghost~ .text-muted+ span") %>% html_text()
  
  certificate=  page %>% html_nodes(".certificate") %>% html_text()
   
  genre = page %>% html_nodes(".genre") %>% html_text()
  
  movies = rbind(movies,data.frame(movie_links,name,certificate,year,genre ,rating,
                                   synopsis,runtime,score,votes,collection,director_stars,
                                   stringsAsFactors = FALSE))
 
   
  print(paste("page:",page_result))
 
 
}

write.csv(movies, "movies.csv") 