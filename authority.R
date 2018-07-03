library(tidyverse)
library(data.table)
library(xml2)

# avg = 6.6
get.movies = function(year) {
    page = sprintf("https://www.scaruffi.com/cinema/best%02d.html",
                   year %% 100)
    listing = read_html(page)
    
    listings = listing %>% 
        xml_find_all("//td") %>% #[@bgcolor='00aaaa']") %>% 
        xml_text() %>%
        strsplit("\n") %>%
        unlist()
    
    movie.regex = "^ *([0-9.]+) (.+): (.+)$"
    listings = listings[grepl("^ *[0-9][.][0-9]",listings)]
    scores = as.numeric(gsub(movie.regex,"\\1",listings))
    director =          gsub(movie.regex,"\\2",listings)
    name =              gsub(movie.regex,"\\3",listings)
    
    data.frame(score = scores,
               director, 
               name,
               year)
}

years = 1998:2018

movies = rbindlist(lapply(years, get.movies)) %>% 
    mutate(name = gsub(" [(][1-2][0-9]{3}[)]$","",name),
           director = trimws(director),
           name = trimws(name),
           foreign = grepl("^.+/",name),
           name = gsub("^.+/","",name)) %>%
    na.omit() %>% 
    group_by(director, name) %>%
    summarise(score = round(mean(score),1),
              year = min(year),
              foreign = all(foreign)) %>%
    ungroup() %>%
    unique()



write.csv(movies,"critic.csv")
