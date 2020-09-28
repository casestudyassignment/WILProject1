# SERVER SIDE TO READ DATASET

library(readr)
library(readxl)

getCSV <- function(input, output) {
  file <- paste("data/", input, sep="")
  data <- read_csv(file)
  return(data)
}

getXLSX <- function(input, output) {
  file <- paste("data/", input, sep="")
  data <- read_excel(file)
  return(data)
}
