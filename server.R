library(shiny)
library(tm)
library(stringr)

quadgram <- readRDS("quadgram.RData")
trigram <- readRDS("trigram.RData")
bigram <- readRDS("bigram.RData")

PredictNextWord <- function(text) {
  cleanText <- removePunctuation(removeNumbers(tolower(text)))
  textString <- strsplit(cleanText, " ")[[1]]
  
  if (length(textString) >= 3) {
    textString <- tail(textString, 3)
    if (identical(character(0), head(quadgram[quadgram$unigram == textString[1] & quadgram$bigram == textString[2] & quadgram$trigram == textString[3], 4], 1))){
      PredictNextWord(paste(textString[2], textString[3],sep=" "))
    }
    else {head(quadgram[quadgram$unigram == textString[1] & quadgram$bigram == textString[2] & quadgram$trigram == textString[3], 4],1)}
  }
  else if (length(textString) == 2){
    textString <- tail(textString,2)
    if (identical(character(0),head(trigram[trigram$unigram == textString[1] & trigram$bigram == textString[2], 3],1))) {
      PredictNextWord(textString[2])
    }
    else {head(trigram[trigram$unigram == textString[1] & trigram$bigram == textString[2], 3],1)}
  }
  else if (length(textString) == 1){
    textString <- tail(textString, 1)
    if (identical(character(0),head(bigram[bigram$unigram == textString[1], 2],1))) {head("the", 1)}
    else {head(bigram[bigram$unigram == textString[1], 2], 1)}
  }
}

shinyServer(function(input, output) {
  output$pred <- renderText({
    result <- PredictNextWord(input$textIn)
    result
  })
})

