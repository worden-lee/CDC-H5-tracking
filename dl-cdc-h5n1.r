## download the latest H5 detected/not detected dataset from CDC
library(jsonlite)
library(tidyverse)
library(purrr)
library(magrittr)
today.date = lubridate::today()

## may warn of incomplete final line, not a problem
json = readLines(url('https://www.cdc.gov/wcms/vizdata/NCEZID_DIDRI/FluA/H5N1Map.json'))
h5n1map = fromJSON(json)
(h5n1map
  %>% mutate(download_date = today.date)
  %T>% write.csv(paste0('cdc-h5n1-',as.character(as.Date(today.date)),'.csv'))
)
