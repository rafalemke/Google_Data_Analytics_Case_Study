library(ggplot2)
library(lubridate)
library(tidyverse)
trips2023_v2 <- read.csv("C:/Users/Rafa_/Documents/GitHub/Google_Data_Analytics_Case_Study/trips_2023_v2.csv")

str(trips2023_v2)
colnames(trips2023_v2)
tibble(trips2023_v2)


# total de viagens entre membros e casuais
count_members <- table(trips2023_v2$member_casual)
print(count_members)


# Proporção de membros
prop_members <- prop.table(count_members) * 100
print(prop_members)


# viagens mensais por tipo de membro
trips_month <- aggregate(trips2023_v2$member_casual ~ trips2023_v2$month, FUN = table)
print(trips_month)


# Viagens semanais por tipo de membro --- TODO
# gerar grafico

trips_week <- trips2023_v2 %>%
  group_by(day_of_week, member_casual) %>%
  summarise(numero_corridas = n())

head(trips_week)




# Duração média por dia da semana
media_semanal <- trips2023_v2 %>%
  group_by(member_casual, day_of_week) %>%
  summarise(media_duracao = mean(ride_length / 60))
print(media_semanal)


# Numero de corridas por horário
trips_hour <- trips2023_v2 %>%
  group_by(hora_inicio, member_casual) %>%
  summarise(numero_corridas = n()) 

print(n = 50, trips_hour)
