## Including the required R packages.
packages <- c('shiny', 'shinyjs')
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

library(shiny)
library(shinyjs)

shinyUI(fluidPage(
  tags$head(tags$script(src = "script.js")),
  titlePanel('Reddit Chatbot'),
  mainPanel(width = '100%',
    useShinyjs(),
    h4(id='status', 'Please wait, loading ..'),
    verbatimTextOutput('history'),
    textInput('text', NULL, width = '100%'),
    actionButton('talk', 'Talk')
  )
))