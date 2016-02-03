library(jsonlite)
library(stringdist)

corpus <- data.frame()

loadFile <- function(pathName) {
  corpus <<- rbind(corpus, fromJSON(pathName))
}

load <- function() {
  # Datasets downloaded from http://couch.whatbox.ca:36975/reddit/comments/monthly/ (note, json needs [ at front and ] at end of file, also replace "}\n" with "},\n" for correct JSON format).
  cat('Loading..')
  loadFile('data/RC_2007-10')
  cat('1..')
  loadFile('data/RC_2007-11')
  cat('2..')
  loadFile('data/RC_2007-12')
  cat('3..')
  loadFile('data/RC_2008-01')
  cat('4..')
  loadFile('data/RC_2008-02')
  cat('Done.')
}

mydist <- function (str1, str2) {
  # Simple string distance using 'osa'.
  (1 - (stringdist(str1, str2) / pmax(nchar(str1), nchar(str2))))
}

similar <- function(text, corpus) {
  # Find the most similar comment as text within the corpus.
  # Get the string distances from the supplied text.
  dists <- mydist(text, corpus$body)

  # Sort matching comments by distance.
  sorted <- corpus[order(dists, decreasing = TRUE),]

  # Find first comment with child comments.
  index <- 1
  parent <- sorted[index,]
  children <- corpus[corpus$parent_id == parent$name,]
  
  while (index <= nrow(sorted) && nrow(children) == 0) {
    # Select next comment.
    index <- index + 1
    parent <- sorted[index,]
    children <- corpus[corpus$parent_id == parent$name & corpus$body != '[deleted]',]
  }
  
  parent
}

bestVote <- function(parent, corpus) {
  # Find the highest voted child comment under a parent.
  # Get all child comments for the parent.
  children <- corpus[corpus$parent_id == parent$name,]
  
  # Sort the children by vote (ups).
  children <- children[order(children$ups),]
  
  children[1,]
}

talk <- function(text) {
  parent <- similar(text, corpus)
  #print(parent$body)
  best <- bestVote(parent, corpus)
  print(best$body)
}