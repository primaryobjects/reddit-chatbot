## Including the required R packages.
packages <- c('shiny', 'shinyjs')
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

library(shiny)
library(shinyjs)

source('reddit-chatbot.R')
loadFile('data/RC_2007-10')

shinyServer(function(input, output, session) {
  history <- '> Hello'

  # Enable controls.
  hide(id = 'status', anim = TRUE)
  enable('talk')
  enable('text')
  
  output$history <- eventReactive(input$talk, ignoreNULL = FALSE, {
    # Append user text.
    history <<- paste(history, input$text, sep = '\n')
    
    # Respond to user.
    if (nchar(input$text) > 0) {
      history <<- paste(history, paste('>', talk(input$text), sep = ' '), sep = '\n')
    }
    
    # Clear textbox.
    updateTextInput(session, 'text', '', NA)
    
    history
  })
})