library(tidyverse)
library(data.table)

# source("authority.R")

imdb = fread( "./title akas/data.tsv") %>%
  filter(title %in% movies$name) %>%
  select(titleId,
         title) %>%
  unique() %>%
  merge(fread("./title ratings/data.tsv") %>%
          rename(titleId = tconst)) %>%
  # filter(numVotes >= 100,
  #        averageRating >= 6.6) %>%
  rename(name = title) %>%
  merge(fread("critic.csv")) %>%
  select(-titleId) %>%
  unique()


str(movies)

# best = temp1 %>%
#   group_by(name,director) %>%
#   summarise(averageRating = min(averageRating),
#             score = min(score),
#             numVotes = min(numVotes),
#             year = min(year),
#             foreign = any(foreign)) %>%
#   ungroup() %>%
#   mutate(consensus = pmin((averageRating - mean(averageRating))/sd(averageRating)
#                           , (score - mean(score))/sd(score))) %>%
#   arrange(desc(year), desc(consensus)) # %>%
#   # filter(consensus > 0) %>%
#   # select(-consensus) %>%
#   # filter(
#   #   score >= 6.6,
#   #   averageRating >= 6.8,
#   #   numVotes >= 1000,
#   #   year > 2008,
#   #   !foreign
#   # )


write.csv(imdb, "imdb.csv",row.names = FALSE)
