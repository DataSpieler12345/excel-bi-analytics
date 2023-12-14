rm(list = ls())
options(scripen=999)

library(syuzhet)
library(dplyr)
library(rwhatsapp)

#la ruta del directorio en donde este el archivo con los datos
setwd("C:\\Data")

#leer el archivo
chat <- rwa_read("Chat.txt", encoding = "UTF-8")

chat2 = filter(chat, chat$text != "<Multimedia omitido>")
chat2 = chat2[!is.na(chat2$author),]

subchat = chat2[,c(1:3,5)]
colnames(subchat) <- c("fecha", "autor", "mensaje", "id")

# funcion para hacer la mineria de opinion 
scoresentiment = function(tab)
{
  tab$syuzhet = get_sentiment(tab$mensaje, method="syuzhet", language = "spanish")
  tab$bing = get_sentiment(tab$mensaje, method="bing", language = "spanish")
  tab$afinn = get_sentiment(tab$mensaje, method="afinn", language = "spanish")
  tab$nrc = get_sentiment(tab$mensaje, method="nrc", language = "spanish")
  emotions = get_nrc_sentiment(tab$mensaje, language = "spanish")
  n = names(emotions)
  for (nn in n) tab[, nn] = emotions[nn]
  return(tab)
}


#aplicar la funcion al dataset
datos <- scoresentiment(subchat)
rm("chat", "chat2", "subchat")
