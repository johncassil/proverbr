#insert libraries here
library(dplyr)
library(httr)
library(jsonlite)
library(purrr)
library(tibble)
library(readr)

#Function to get the texts from Sefaria's API:
grab_data <- function(text){
    
    #Get the data:
    res <- httr::GET(paste0('https://www.sefaria.org/api/texts/', text, '?context=0&pad=0'))
    
    #Unpack it:
    data <- jsonlite::fromJSON(rawToChar(res$content)) %>% .$text
}

#Texts we are interested in for this:
texts <- c('Proverbs', 'Ecclesiastes', 'Proverbs')

#Get the data:
data <- texts %>% purrr::map(grab_data) %>% unlist() %>% unlist(data) %>% tibble::enframe(name = NULL)

data %>% readr::write_csv('raw_data_from_sefaria.csv')

