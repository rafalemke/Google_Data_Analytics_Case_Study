library(ggplot2)

aggregate(trips2023_v2$ride_length ~ trips2023_v2$member_casual, FUN = mean)
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
  geom_text(aes(y = Freq/2 + c(0, cumsum(Freq)[-length(Freq)]), label = paste0(round(Freq, 1), "%")), position = position_stack(vjust = 0.5), size = 5) +
  theme_void() +
  labs(fill = "Tipo de cliente", title = "Percentual de corridas: Member vs Casual", subtitle = "janeiro a dezembro de 2023") +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
  

