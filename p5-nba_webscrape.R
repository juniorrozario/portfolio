install.packages('rvest')
install.packages('dplyr')

library(rvest)
library(dplyr)

link = 'https://www.basketball-reference.com/awards/all_star_by_player.html'
page = read_html(link)

rank = page %>%  html_nodes('') %>%  html_text()
name = page %>%  html_nodes('#all_star_by_player a') %>%  html_text()
num_of_selections = page %>%  html_nodes('.center:nth-child(3)') %>%  html_text()

name
num_of_selections

all_star = data_frame(name, num_of_selections, stringsAsFactors = FALSE)

write.csv(all_star, 'nba_all_star')
download.file('nba_all_star')
