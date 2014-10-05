#### IS 607 Week 6 Assignment ####
#### Stacey Schwarcz ####

#### Lego movie test code test case####

library(rvest)
lego_movie <- html("http://www.imdb.com/title/tt1490017/")

rating <- lego_movie %>% 
  html_nodes("strong span") %>%
  html_text() %>%
  as.numeric()
rating
#> [1] 7.9

cast <- lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()
cast
#>  [1] "Will Arnett"     "Elizabeth Banks" "Craig Berry"     "Alison Brie"    
#>  [5] "David Burrows"   "Anthony Daniels" "Charlie Day"     "Amanda Farinos" 
#>  [9] "Keith Ferguson"  "Will Ferrell"    "Will Forte"      "Dave Franco"    
#> [13] "Morgan Freeman"  "Todd Hansen"     "Jonah Hill"     

poster <- lego_movie %>%
  html_nodes("#img_primary img") %>%
  html_attr("src")
poster
#> "http://ia.media-imdb.com/images/M/....jpg"

#### Different Website: ####

new_website <- html("http://seekingalpha.com/article/2539195-scared-money-where-to-invest-now")

summary <- new_website %>%
  html_nodes("#summary_content") %>%
  html_text()
cat(summary, "\n") 

#Output:  
#Summary
#    As the U.S bull market has pushed stock valuations higher for the past five years, investors 
#have put money on the sidelines due to market correction fears.
#        
#    While the general market held up without a correction in Q3, income-related investments have seen 
#capital destruction due to rate-hike fears.
#        
#    For income-investors with sideline cash looking to find value today, many income-related 
#investments have fallen and offer "on sale" value.
#        
#    A list of my top five income-investment "sale" ideas including REITs, closed-end bond funds and a  
#business development company.
