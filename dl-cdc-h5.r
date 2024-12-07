## download the latest H5 detected/not detected dataset from CDC
## https://www.cdc.gov/nwss/rv/wwd-h5.html
library(jsonlite)
library(tidyverse)
library(purrr)
library(magrittr)

## get the metadata
## may warn of incomplete final line, not a problem
meta.json = readLines(url('https://www.cdc.gov/wcms/vizdata/NCEZID_DIDRI/FluA/H5N1Databites.json'))
meta.df = fromJSON(meta.json)
time.period = meta.df$`Time-Period-Map`[[1]]

## may warn of incomplete final line, not a problem
map.json = readLines(url('https://www.cdc.gov/wcms/vizdata/NCEZID_DIDRI/FluA/H5N1Map.json'))
map.df = (fromJSON(map.json)
  %>% mutate(time.period = time.period)
  %T>% {
    csvpath = file.path('cdc-h5-data',paste0('cdc-h5-',time.period,'.csv'))
    cat('> ',csvpath,'\n')
    write.csv(.,csvpath)
  }
)

if(0) {
  ## check data against summary in metadata
  sum(map.df$Detection_Category=='No Samples in Last Week')
  sum(map.df$Detection_Category=='No Detection')
  sum(map.df$Detection_Category=='H5 Detection')
}
