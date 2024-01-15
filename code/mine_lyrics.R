library(tidyverse)
library(rvest)

TOP_SINGLES <- tibble(year = integer(), position = integer(), title = character(), artist = character())
years <- 1946:2023 # could be not-hardcoded
link <- "https://en.wikipedia.org/wiki/Billboard_Year-End_Hot_100_singles_of_%d"

for (year in years) {
  
topSingles <- read_html(sprintf(link, year)) %>% 
  html_element("table.wikitable") %>% 
  html_table(na.strings = NA_character_, convert = FALSE) 

TOP_SINGLES <- topSingles %>% 
  separate_wider_delim(1, delim = " ", names = "Position", too_many = "drop") %>% 
  mutate(
    year,
    position = as.integer(Position), 
    title = trimws(Title, whitespace = "\""), 
    artist = `Artist(s)`,
    .keep = "none"
  ) %>% 
  bind_rows(TOP_SINGLES, .)
}



# there was Tie in 58 and 69 (nice)
# 1997 98 You're Makin' Me High" / "Let It Flow Toni Braxton (two songs??? wtf)
# use separate_longer ofc but read about this phenomenon

library(geniusr)

get_lyrics_search("Morgan Wallen", "Last Night")

geniusr::search_song("Morgan Wallen Last Night")
