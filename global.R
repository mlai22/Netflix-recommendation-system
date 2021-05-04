require(shiny)
require(tidyverse)
require(DT)
require(plotly)
require(ggplot2)
require(wordcloud2)
require(shinycssloaders)
# Options for Spinner
options(spinner.color="#0275D8", spinner.color.background="#ffffff", spinner.size=2)

source("recommender.R")

dat <- read_csv('data/netflix_titles.csv')
binary_movie <- read.csv('data/binary_movies.csv', header = T)
binary_tv <- read.csv('data/binary_tv.csv', header = T)

dat1 <- dat %>%
  filter(!is.na(cast) & !is.na(country) & !is.na(rating))


