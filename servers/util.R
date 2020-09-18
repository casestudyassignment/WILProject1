# SERVER SIDE TO READ DATASET

library(readr)

getCSV <- function(input, output) {
  file <- paste("data/", input, sep="")
  data <- read_csv(file)
  return(data)
}
