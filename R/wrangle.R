library(tidyverse)
library(jsonlite)
library(furrr)
plan(multisession)

parse_individual_file <- function(filename){
  x <- read_json(filename) %>%
    tibble() %>%
    unnest_wider(1) %>%
    filter(.data$user == "UU8KP9KR9") %>%
    select(any_of(c("ts", "thread_ts", "user", "text", "type")))

  x$filename <- filename

  return(x)
}

slack_messages <- list.files(path = ".", pattern = "202.*json",recursive = TRUE,full.names = TRUE) %>%
  future_map_dfr(parse_individual_file) %>%
  extract(filename,
          into = c("channel","date"),
          regex = ".+/(.+)/(.*)\\.json")

slack_messages <- slack_messages %>%
  mutate(date = lubridate::as_date(date),
         year = lubridate::year(date),
         month = lubridate::month(date),
         ym = paste(year,str_pad(month,2,pad = "0"),sep = "-")) %>%
  mutate(message_type = case_when(str_starts(channel, "help") ~ "help",
                                  str_starts(channel, "book") ~ "book club",
                                  TRUE ~ "other")
  ) %>%
  group_by(ym,message_type) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  filter(ym != "2021-08")

saveRDS(slack_messages,"data/tan_slack_messages.rds")
