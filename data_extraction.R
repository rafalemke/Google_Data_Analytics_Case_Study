install.packages("tidyverse")
install.packages("ggplot")
install.packages("lubridate")

library(tidyverse)
library(ggplot2)
library(lubridate)
library(tidyr)

# Carregar arquivos .csv em um dataframe

jan2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202301-divvy-tripdata.csv")
feb2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202302-divvy-tripdata.csv")
mar2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202303-divvy-tripdata.csv")
apr2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202304-divvy-tripdata.csv")
may2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202305-divvy-tripdata.csv")
jun2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202306-divvy-tripdata.csv")
jul2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202307-divvy-tripdata.csv")
aug2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202308-divvy-tripdata.csv")
sep2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202309-divvy-tripdata.csv")
oct2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202310-divvy-tripdata.csv")
nov2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202311-divvy-tripdata.csv")
dec2023 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/divvy-tripdata2023/202312-divvy-tripdata.csv")

# Criando uma lista com os datasets e verificando se todos têm o mesmo formato
datasets <- list(jan2023, feb2023, mar2023, apr2023, may2023, jun2023, jul2023, aug2023, sep2023, oct2023, nov2023, dec2023)

# Função para verificar se duas listas são iguais
list_equals <- function(list1, list2) {
  identical(names(list1), names(list2))
}

# Verificar se todos os datasets têm as mesmas colunas
all_equal_columns <- all(sapply(datasets[-1], function(x) list_equals(colnames(datasets[[1]]), colnames(x))))

# Imprimir o resultado
if (all_equal_columns) {
  print("Todos os datasets têm as mesmas colunas.")
} else {
  print("Os datasets têm colunas diferentes.")
}


# Unindo todos os datasets em um só após verificar que todos tem as mesmas colunas.
trips2023 <- bind_rows(jan2023, feb2023, mar2023, apr2023, may2023, jun2023, jul2023, aug2023, sep2023, oct2023, nov2023, dec2023)

head(trips2023)
colnames(trips2023)
str(trips2023)


# Retirando colunas que não iremos usar nessa análise.
trips2023 <- trips2023 %>%
  select(-c(start_lat, start_lng, end_lat, end_lng,ride_id, start_station_id, end_station_id))

str(trips2023)


# Função para apagar linhas com dados em branco.
trips2023 <- drop_na(trips2023)
str(trips2023)
summary(trips2023)


customer_counts <- table(trips2023$member_casual)
print(customer_counts)


# Criação de colunas com dados de dia, mês, ano e dia da semana.
trips2023$date <- as.Date(trips2023$started_at) #The default format is yyyy-mm-dd
trips2023$month <- format(as.Date(trips2023$date), "%m")
trips2023$day <- format(as.Date(trips2023$date), "%d")
trips2023$year <- format(as.Date(trips2023$date), "%Y")
trips2023$day_of_week <- format(as.Date(trips2023$date), "%A")
head(trips2023)


# Criação de coluna com dados do tempo da corrida em segundos.
trips2023$ride_length <- difftime(trips2023$ended_at,trips2023$started_at)


# Criação de colunas com horários de inicio e fim
trips2023 <- trips2023%>% mutate(hora_inicio = format(as.POSIXct(started_at), format = "%H:%M:%S"))
trips2023 <- trips2023%>% mutate(hora_fim = format(as.POSIXct(ended_at), format = '%H:%M:%S'))
head(trips2023)
str(trips2023)




head(trips2023)
# Apagando colunas sem utilização posterior.
trips2023 <- trips2023 %>%
  select(-c(started_at, ended_at)) 



# Transformando a coluna ride_length em numérico.
trips2023$ride_length <- as.numeric(as.character(trips2023$ride_length))



# Apagando dados com duração de corrida < 60 ou > 86400(24 horas).
trips2023_v2 <- trips2023[!(trips2023$ride_length<60 | trips2023$ride_length>86400),]



# Verificar se existe alguma coluna com dados em branco.
num_na <- sapply(trips2023, function(x) sum(is.na(x)))
print(num_na)

valores_ordenados <- sort(trips2023_v2$ride_length, decreasing = FALSE)
head(valores_ordenados,100)



# Funções de media e mediana 
aggregate(trips2023_v2$ride_length ~ trips2023_v2$member_casual, FUN = mean)
aggregate(trips2023_v2$ride_length ~ trips2023_v2$member_casual, FUN = median)



# Apagando linhas com dadosdos nome de estações em branco
trips2023_v2 <- subset(trips2023_v2, nchar(start_station_name) > 0 & nchar(end_station_name) > 0)





str(trips2023_v2)


# Transformando dados da hora_inicio em apenas o numero da hora.
trips2023_v2$hora_inicio<- substr(trips2023_v2$hora_inicio, 1, 2)
head(trips2023_v2)
trips2023_v2 <- trips2023_v2 %>%
  select(-c(hora_fim, hora))


# Salvando novo dataframe limpo e pronto para análise e visualização.
write.csv(trips2023_v2, file="C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/trips_2023_v2.csv")
