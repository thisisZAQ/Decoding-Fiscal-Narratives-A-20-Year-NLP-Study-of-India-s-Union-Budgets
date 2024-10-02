install.packages("quanteda") 
install.packages("tidyverse")
install.packages("‘quanteda.textplots") 

library(quanteda)
library(quanteda.textplots)
library(tidyverse)

d <- read_csv('budget_news.csv',col_names = TRUE)
head(d)
## view first 6 rows

corp <- corpus(d, text_field = 'content')  ## create the corpus
corp

dtm <- corp |>
  tokens(remove_punct = T, remove_numbers = T, remove_symbols = T) |>   
  tokens_tolower() |>                                                    
  tokens_remove(stopwords('en')) |>     
  tokens_remove("budget") |>
  tokens_remove("rs") |>
  tokens_remove("indian") |>
  tokens_remove("government") |>
  tokens_remove("minister") |>
  tokens_remove("nirmala") |>
  tokens_remove("sitharaman") |>
  tokens_remove("sectors") |>
  tokens_remove("sector") |>
  tokens_remove("expectations") |>
  dfm()
dtm

dtm <- dfm_trim(dtm, min_termfreq = 5)
dtm

textplot_wordcloud(dtm, max_words = 50)                          ## top 50 (most frequent) words
textplot_wordcloud(dtm, max_words = 20, color = c('blue','red')) ## change colors
textstat_frequency(dtm, n = 10)                                

## view the frequencies 

infrastructure <- kwic(tokens(corp), 'infrastructure*')
infrastructure_corp <- corpus(infrastructure)
infrastructure_dtm <- infrastructure_corp |>
  tokens(remove_punct = T, remove_numbers = T, remove_symbols = T) |>
  tokens_tolower() |>
  tokens_remove(stopwords('en')) |>
  tokens_wordstem() |>
  dfm()

textplot_wordcloud(infrastructure_dtm, max_words = 50) ## top 50 (most frequent) words

fiscal <- kwic(tokens(corp), 'fiscal*')
fiscal_corp <- corpus(fiscal)
fiscal_dtm <- fiscal_corp |>
  tokens(remove_punct = T, remove_numbers = T, remove_symbols = T) |>
  tokens_tolower() |>
  tokens_remove(stopwords('en')) |>
  tokens_wordstem() |>
  dfm()

textplot_wordcloud(fiscal_dtm, max_words = 50) ## top 50 (most frequent) words




