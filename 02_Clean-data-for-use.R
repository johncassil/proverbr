library(readr)
library(dplyr)
# library(tidyr)
library(stringr)
    

data <- readr::read_csv('raw_data_from_sefaria.csv')

    #Clean it up a bit:
proverb_data <- data %>%
    # tidyr::separate_rows(value, sep = ';') %>%
    mutate(value = stringr::str_to_lower(value),
           value = stringr::str_replace_all(value, '<i>', ''),
           value = stringr::str_replace_all(value, '</i>', ''),
           # value = stringr::str_replace_all(value, '[^a-zA-Z ]+', ''),
           # value = stringr::str_replace_all(value, '  ', ' ')
    ) %>% 
    filter(value != "") %>% 
    mutate(id = row_number())

#Save it:
proverb_data %>% readr::write_csv('proverbs.csv')
