library(ggplot2)
library(lubridate)
library(tidyverse)
trips2023_v2 <- read.csv("###/GitHub/Google_Data_Analytics_Case_Study/trips_2023_v2.csv")

aggregate(trips2023_v2$ride_length ~ trips2023_v2$member_casual + trips2023_v2$day_of_week, FUN = mean)
aggregate(trips2023_v2$ride_length ~ trips2023_v2$member_casual, FUN = median)
aggregate(trips2023_v2$ride_length ~ trips2023_v2$member_casual, FUN = max)
aggregate(trips2023_v2$ride_length ~ trips2023_v2$member_casual, FUN = min)




# Criando um gráfico de pizza com o percentual de corridas entre cada tipo de cliente:

counts <- table(trips2023_v2$member_casual) 

counts <- prop.table(counts) * 100  

df <- as.data.frame(counts) 

ggplot(df, aes(x = "", y = Freq, fill = Var1)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  geom_text(aes(y = Freq/2 + c(0, cumsum(Freq)[-length(Freq)]), label = paste0(round(Freq, 1),
       "%")), position = position_stack(vjust = 0.5), size = 5) +
  theme_void() +
  labs(fill = "Tipo de cliente", title = "Percentual de corridas: Member vs Casual",
       subtitle = "janeiro a dezembro de 2023") +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
  


# Criando um gráfico de barras com a média de minutos semanais por tipo de cliente.

media_semanal <- trips2023_v2 %>%
  group_by(member_casual, day_of_week) %>%
  summarise(media_duracao = mean(ride_length / 60))

media_semanal$day_of_week <- factor(media_semanal$day_of_week,
                                    levels = c("segunda-feira", "terça-feira",
                                    "quarta-feira", "quinta-feira", "sexta-feira",
                                      "sábado", "domingo"))
print(media_semanal)

ggplot(media_semanal, aes(x = day_of_week, y = media_duracao, fill = member_casual)) +
  geom_col(position = position_dodge(width = 0.6), width = 0.5) +
  labs(title = "Média de duração dos passeios por dia da semana",
       x = "Dia da semana",
       y = "Média de duração (minutos)",
       fill = "Tipo de cliente") +
  scale_x_discrete(labels = c("seg", "ter", "qua", "qui", "sex", "sab", "dom")) +
  scale_y_continuous(limits = c(0,30),breaks = c(0,5,10,15,20,25,30)) +
  theme(plot.title.position = "plot",
        axis.text.x = element_text(hjust = 0.5), plot.title = element_text(hjust = 0.5))




# Gráfico com o numero de corridas por mês entre membros e clientes casuais.



trips_month <- trips2023_v2 %>%
  group_by(date, member_casual) %>%
  summarise(numero_corridas = n())


print(trips_month)


trips_month <- trips_month %>%
  group_by(date = format(date, "%Y-%m"), member_casual) %>%
  summarise(numero_corridas = sum(numero_corridas))

trips_month <- trips_month %>%
  mutate(date = paste0(date, "-01"))

trips_month <- trips_month %>%
  mutate(date = as.Date(date, format = "%Y-%m-%d"))


ggplot(trips_month, aes(x = date, y = numero_corridas/1000, color = member_casual)) +
  geom_point() +
  geom_line() +
  scale_y_continuous(name = "total de corridas *1000", limits = c(0, 350), breaks = c(0,50,100,150,200,250,300,350)) +
  scale_x_date(date_breaks = "1 month" , date_labels = "%B") +
  theme(axis.text.x = element_text(angle = 20, hjust = 0.5)) +
  theme(axis.title.x = element_blank(), plot.title = element_text(hjust = 0.5)) +
  ggtitle("Total de corridas por mês")
  


# Gráfico contendo o número de corridas por horário

trips_hour <- trips2023_v2 %>%
  group_by(hora_inicio, member_casual) %>%
  summarise(numero_corridas = n())



ggplot(trips_hour, aes(x = hora_inicio, y = numero_corridas/1000, fill = member_casual)) +
geom_col(position = position_dodge(width = 0.8), width = 0.8) +
scale_y_continuous(name = "total de corridas *1000", limits = c(0, 300), breaks = c(0,50,100,150,200,250,300)) +
labs(title = "Número de corridas por horário", x = "Hora de início", y = "Número de corridas") +
scale_x_continuous(name = "hora de inicio", breaks = seq(0, 23, by = 1)) +
theme(plot.title.position = "plot",
  axis.text.x = element_text(hjust = 0.5), plot.title = element_text(hjust = 0.5))




