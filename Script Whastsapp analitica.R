# Remover las variables en memoria
rm(list = ls())

# anular la notación científica en los gráficos
options(scipen=999)

#Carga de las libreias necesarias
library(ggplot2)
library(lubridate)
library(reshape2)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(stringr)
library(syuzhet)
library(dplyr)
library(rwhatsapp)
library(tidyr)

## Nos ubicamos en el directorio
setwd("C:\\Users\\lenovo\\documents\\Mineria de texto")

## Leemos el archivo exportado de Whatsapp
chat <- rwa_read("Chat.txt", encoding = "UTF-8")
Chat_duplicado <- chat

#Agregamos columna dia
chat <- Chat_duplicado %>% mutate(day = date(time))


## Exploramos las primeras filas
head(chat,4)

#Vemos la dimension del chat del grupo
dim(chat)


## Vemos la evolucion en el tiempo del chat
descriptiva <- unlist(chat %>%
                        group_by(day) %>%
                        summarise(mensajes=n()) %>% summarise(min(mensajes),round(mean(mensajes)),max(mensajes)))


chat %>%
  count(day) %>%
  ggplot(aes(x = day, y = n)) +
  geom_bar(stat = "identity", fill="green", alpha=0.8) + 
  ylab("Total mensajes") + xlab("día") + 
  ggtitle("Mensajes por día del mes") + 
  geom_hline(yintercept=descriptiva[2]) + 
  geom_smooth(fill="grey")

## Graficamos los mensajes promedio por dia de la semana

chat %>%
  mutate(dia_semana = wday(day, label = TRUE)) %>% 
  group_by(dia_semana) %>%
  summarise( nn=round(n()/4)) %>%
  ggplot(aes(x = dia_semana, y = nn)) +
  geom_bar(stat = "identity", fill="purple", alpha=0.5) + 
  ylab("mensajes Promedio") + xlab("día") + 
  geom_text(aes(label= nn), vjust=0, hjust=-0.05) + 
  ggtitle("Mensajes promedio por día de la semana")

## Graficamos mensajes por autor
chat %>%
  count(author) %>%
  top_n(n = 10, n) %>%
  ggplot(aes(x = reorder(author, n), y = n)) + 
  geom_bar(stat = "identity", fill="red", alpha=0.5) + 
  ylab("# de mensajes") + xlab( "Autor") + 
  geom_text(aes(label= n), vjust=0, hjust=-0.05) + 
  coord_flip() +
  ggtitle("Mensajes por autor")


## Graficamos el uso por emojies
chat %>%
  unnest(emoji) %>%                                         
    count(emoji, sort = TRUE) %>%  
    top_n(n = 10, n) %>%           
    ggplot(aes(x = reorder(emoji, n), y = n)) + 
    geom_col(show.legend = FALSE, fill="orange", alpha=0.5) + 
    ylab("Cantidad") + xlab( "Emoji") +
    coord_flip() +
    geom_text(aes(label= n), vjust=0, hjust=-0.05) +
    ggtitle("Cantidad de veces de emoji")

## Graficamos la cantidad enviada de multimedias por autor
chat %>%
  filter (text=="<Multimedia omitido>") %>%    
  count(author) %>%  
  top_n(n = 10, n) %>%          
  ggplot(aes(x = reorder(author, n), y = n)) + 
  geom_bar(stat = "identity", fill="yellow", alpha=0.5) + 
  ylab("Cantidad") + xlab( "Autor") +
  coord_flip() +
  geom_text(aes(label= n), vjust=0, hjust=-0.05) +
  ggtitle("Frecuencia de uso de objeto multimedia")

########################################## Analitica del Texto
#### Creamos el curpo del texto a analizar 

docs <- Corpus(VectorSource(chat))

#Limpiar y transformar los datos
trans <- content_transformer(function (x , pattern ) gsub(pattern, " ", x)) 
docs <- tm_map(docs, trans, "/")
docs <- tm_map(docs, trans, "@")
docs <- tm_map(docs, trans, "\\|")
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("spanish"))
docs <- tm_map(docs, removeWords, c("null","chattxt","sofía", "yelena", "yeleyca", "williams", "willian", "daniela", "ninoska", "ruth", "joel", "rocha", "tovar", "raldíriz", "alcalá", "castillo", "multimedia", "omitido" ))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, stemDocument)

### Creamos la matrix de terminos
dtm <- TermDocumentMatrix(docs)
mat <- as.matrix(dtm)
v <- sort(rowSums(mat),decreasing=TRUE)

#Creamos el Data frame
data <- data.frame(word = names(v),freq=v) 
head(data, 10)

#genera la wordcloud
set.seed(245)
wordcloud(words = data$word, freq = data$freq, scale=c(10,2), min.freq = 2,
          max.words=100, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))

#Obtener sentimiento del texto
Sentiment <- get_nrc_sentiment(chat$text, language = "spanish")
head(Sentiment)
text <- cbind(chat,Sentiment)

#contamos el sentimiento por categoria
TotalSentiment <- data.frame(colSums(text[,c(9:18)]))
names(TotalSentiment) <- "count"
TotalSentiment <- cbind("sentiment" = rownames(TotalSentiment), TotalSentiment)
rownames(TotalSentiment) <- NULL
TotalSentiment [order(TotalSentiment$count, decreasing= TRUE),]

#total sentiment positivos y negativos
TotalSentiment$sentiment =with(TotalSentiment, reorder(sentiment,count))

ggplot(data = TotalSentiment[9:10,], aes(x = sentiment, y = count)) +
  geom_bar(aes(fill = sentiment), stat = "identity") +
  geom_text(aes(label= count), vjust=0, hjust=-0.05) +
  theme(legend.position = "none") +
  xlab("") + ylab("Total conteo") + ggtitle("Sentimientos identificados en conversaciones del Grupo")


#total Emociones identificadas
ggplot(data = TotalSentiment[1:8,], aes(x = sentiment, y = count)) +
  geom_bar(aes(fill = sentiment), stat = "identity") +
  geom_text(aes(label= count), vjust=0, hjust=-0.05) +
  theme(legend.position = "none") +
  coord_flip() +
  xlab("") + ylab("Total conteo") + ggtitle("Emociones identificadas en conversaciones del Grupo")


#Palabras mas usadas
data[1:8, ] %>%
  arrange(freq) %>%
  mutate(word=factor(word, levels =word)) %>%
  ggplot( aes(x=word, y=freq)) +
  geom_segment( aes(xend=word, yend=0)) +
  geom_point( size=6, color="orange") +
  coord_flip() +
  theme_bw() +
  xlab("") +
  labs(title = "Palabras más frecuentes en los chats del Grupo", x = "Palabras", y = "Número de usos")

