#android phones
library(stringr)
library(rvest)
library(tidyverse)
url <- "https://www.jumia.co.ke/android-phones/"
read_phone_details <- function(url){
  android <- read_html(url)
  phone_name <- android %>%
    html_nodes(xpath = '//h3[@class="name"]' ) %>%
    html_text() %>%
    as_tibble()
} 
read_new_price <- function(url){
  android <- read_html(url)
  phone_new_price <- android %>%
    html_nodes(xpath = '//div[@class="prc"]') %>%
    html_text() %>%
    as_tibble()
  
}

read_old_price <- function(url){
  android <- read_html(url)
  phone_old_price <- android %>%
    html_nodes(xpath ='//div[@class="old"]' ) %>%
    html_text() %>%
    as_tibble()
}

read_discounts <- function(url){
  android <- read_html(url)
  phone_discount <- android %>%
    html_nodes(xpath ='///div[@class="tag _dsct _sm"]' ) %>%
    html_text() %>%
    as_tibble()
}

read_ratings <- function(url){
  android <- read_html(url)
  phone_rating <- android %>%
    html_nodes(xpath ='///div[@class="rev"]' ) %>%
    html_text() %>%
    as_tibble()
}

# when we observe the links for the proceeding pages we notice a pattern that can be 
# manipulated to obtain a list of all the pages as shown below
pages_2to50 <- c("https://www.jumia.co.ke/android-phones/") %>%
  paste0(c("?page=")) %>%
  paste0(2:50)

# we use the map_dfr to apply the functions above to each page in the list "pages_2to50
# the output will be five tibbles.
names <- map_dfr(pages_2to50, read_phone_details)
new_price <- map_dfr(pages_2to50, read_new_price)
old_price <- map_dfr(pages_2to50, read_old_price)
discounts <- map_dfr(pages_2to50, read_discounts)
ratings <- map_dfr(pages_2to50, read_ratings)


#create a new column for the number of reviewers for each phone
reviewers <- str_extract(phone_rating, "\\(.*\\)")
reviewers <- str_remove_all(reviewers, "[\\(\\)]")

uniques1 <- as.character(unique(unlist(names))) %>%
  as_tibble(uniques) %>%
  View()


#ios phones
library(stringr)
library(rvest)
library(tidyverse)
url_ios <- "" #insert url for iphones
read_phone_details_ios <- function(url_ios){
  ios <- read_html(url_ios)
  phone_name_ios <- ios %>%
    html_nodes(xpath = '' ) %>% #####insert xpath for name
    html_text() %>%
    as_tibble()
} 
read_new_price_ios <- function(url_ios){
  ios <- read_html(url_ios)
  phone_new_price_ios <- ios %>%
    html_nodes(xpath = '') %>% ####insert xpath for new price
    html_text() %>%
    as_tibble()
  
} 

read_old_price_ios <- function(url_ios){
  ios <- read_html(url_ios)
  phone_old_price_ios <- ios %>%
    html_nodes(xpath ='' ) %>% ####insert xpath for old price
    html_text() %>%
    as_tibble()
}

read_discounts_ios <- function(url_ios){
  ios <- read_html(url_ios)
  phone_discount_ios <- ios %>%
    html_nodes(xpath ='' ) %>%   ####insert xpath for discount
    html_text() %>%
    as_tibble()
}

read_ratings_ios <- function(url_ios){
  ios <- read_html(url_ios)
  phone_rating_ios <- ios %>%
    html_nodes(xpath ='' ) %>%    #####insert xpath for ratings or reviews
    html_text() %>%
    as_tibble()
}

# when we observe the links for the proceeding pages we notice a pattern that can be 
# manipulated to obtain a list of all the pages as shown below
pages_2to50 <- c("") %>%  ####change pages to the last page indicated there
  paste0(c("?page=")) %>%
  paste0(2:50) ####change this to 2:"the last number"

# we use the map_dfr to apply the functions above to each page in the list "pages_2to50
# the output will be five tibbles.
names_ios <- map_dfr(pages_2to50, read_phone_details_ios) ###change pages_2to50 
new_price_ios <- map_dfr(pages_2to50, read_new_price_ios) ###change pages_2to50 
old_price_ios <- map_dfr(pages_2to50, read_old_price_ios) ###change pages_2to50 
discounts_ios <- map_dfr(pages_2to50, read_discounts_ios) ###change pages_2to50 
ratings_ios <- map_dfr(pages_2to50, read_ratings_ios) ###change pages_2to50 


#create a new column for the number of reviewers for each phone
reviewers_ios <- str_extract(phone_rating_ios, "\\(.*\\)")
reviewers_ios <- str_remove_all(reviewers_ios, "[\\(\\)]")

uniques1 <- as.character(unique(unlist(names))) %>%
  as_tibble(uniques) %>%
  View()