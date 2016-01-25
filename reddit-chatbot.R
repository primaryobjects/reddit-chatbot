library(jsonlite)
library(stringdist)

# Datasets downloaded from http://couch.whatbox.ca:36975/reddit/comments/monthly/ (note, json needs [ at front and ] at end of file, also replace "}\n" with "},\n" for correct JSON format).
corpus <- fromJSON('RC_2007-10')
corpus <- rbind(corpus, fromJSON('RC_2007-11'))
corpus <- rbind(corpus, fromJSON('RC_2007-12'))
corpus <- rbind(corpus, fromJSON('RC_2008-01'))
corpus <- rbind(corpus, fromJSON('RC_2008-02'))

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