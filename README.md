# Google_Data_Analytics_Case_Study
Repositório contendo um estudo de caso do curso de análise de dados da Google, ministrado pelo Coursera.

# Introdução
   O estudo de caso é sobre a Cyclistic, uma empresa fictícia de compartilhamento de bicicletas em Chicago, EUA. Como suposto analista de dados júnior, seguirei as etapas do processo de análise de dados para responder às principais perguntas de negócios. <br> <br>As etapas incluem perguntar, preparar, processar, analisar, compartilhar e agir.

# Cenário
A Cyclistic, desde seu lançamento em 2016, expandiu-se para 5.824 bicicletas em 692 estações em Chicago, promovendo flexibilidade com passes de viagem única, diários e anuais. Com foco em conscientização geral, a estratégia destaca a lucratividade dos membros anuais, impulsionando a iniciativa de converter passageiros casuais em membros. Lily Moreno, diretora de marketing, busca entender as diferenças entre os grupos, motivos para os casuais aderirem a planos anuais e como a mídia digital pode influenciar. O objetivo é otimizar a estratégia, aproveitando dados históricos de trajetos de bicicleta para identificar tendências.

## Perguntar
Lily propôs a primeira pergunta-chave: <strong> Como os membros anuais e os ciclistas casuais usam as bicicletas da Cyclistic de forma diferente? </strong> <br>
Vamos analisar dados históricos para entender essas distinções e orientar a criação de estratégias de marketing com base nos insights obtidos com os dados.

## Preparar
Usarei dados históricos dos trajetos realizados entre janeiro e dezembro de 2023. Os dados foram disponibilizados pela Motivate International Inc. sob a seguinte [licença](https://www.divvybikes.com/data-license-agreement). Os dados são públicos e podem ser usados livremente para essa análise.

Os dados estão organizados em 12 diferentes arquivos csv, nomeados por mês e ano, contendo informações de cada corrida, como origem, destino, data, hora, id do usuário dentre outras.

## Processar e Analisar
Devido ao tamanho dos arquivos, que ultrapassam 6 milhões de linhas, optei por manipular os dados utilizando a linguagem R junto com o software RStudio. A utilização de planilhas nesse caso seria inviável devido ao grande número de linhas. Poderia também utilizar o BigQuery ou Python, visto que já tenho mais afinidade, mas escolhi o RStudio pelo desafio de uma nova linguagem.
<br>
   - [link](https://github.com/rafalemke/Google_Data_Analytics_Case_Study/edit/main/data_extraction.R) com o script "data_extraction".
   - [Link](https://github.com/rafalemke/Google_Data_Analytics_Case_Study/edit/main/data_exploration.R) com o script "data_exploration".

### Segue um resumo de todo tratamento feito com os dados obtidos.



**1. Carregamento dos Pacotes:**
   - tidyverse, ggplot2, lubridate, e tidyr são pacotes essenciais para análise e manipulação.

**2. Carregamento dos Dados:**
   - Carregamento de dados mensais (jan-dez/2023) de arquivos CSV para dataframes.

**3. Verificação da Consistência dos Datasets:**
   - Utilização de uma função para verificar consistência nas colunas.

**4. Concatenação dos Datasets:**
   - Uso de bind_rows para unir os datasets em um único dataframe (trips2023).

**5. Limpeza e Seleção de Colunas:**
   - Remoção de colunas desnecessárias.
   - Utilização de drop_na para remover linhas com dados em branco.

**6. Análise Exploratória de Dados:**
   - Criação de variáveis de data, mês, ano, dia da semana, e cálculo da duração da corrida.

**7. Manipulação de Dados Temporais:**
   - Transformação da duração em numérica.
   - Exclusão de dados com duração fora do intervalo desejado.

**8. Análise Estatística:**
   - Verificação e remoção de dados faltantes.
   - Exibição dos 100 menores tempos de corrida.
   - Cálculo de médias e medianas de duração por tipo de cliente.

**9. Limpeza Adicional:**
   - Remoção de linhas com nomes de estações em branco.

**10. Transformação e Salvamento:**
   - Conversão dos horários para apenas a hora.
   - Seleção final de colunas e salvamento do dataframe limpo em CSV.
**11. Distribuição dos Tipos de Membros:**

   - Verifica-se a distribuição percentual de membros nos grupos "member" e "casual" para compreender a participação relativa de cada categoria.

**12. Análise Temporal:**

   - Explora-se padrões ao longo do tempo, investigando variações mensais, diárias e por dia da semana. Compara-se a frequência de viagens entre membros "member" e "casual" em diferentes períodos.

**13. Duração Média de Viagens:**

   - Calcula-se a duração média de viagens para cada tipo de membro e compara-se as médias, identificando eventuais diferenças significativas.

**14. Análise de Horários:**

   - Investiga-se os horários mais comuns de início para cada tipo de membro. Analisa-se se existem diferenças nos padrões de uso ao longo do dia.

<br>

Na próxima etapa será melhor detalhado, visto que a visualização dos gráficos ajudam bastante na compreensão dos dados.


## Compartilhar

   1. ### Análise de Viagens entre Clientes Membros e Casuais

      Primeiramente, realizamos uma análise do número total de registros de viagens entre clientes membros e casuais.

<p align="center">
  <img src="https://github.com/rafalemke/Google_Data_Analytics_Case_Study/blob/main/images/trips_total_percentage.png" alt="image">
</p>

   Com base nos dados que indicam que 64,5% dos clientes são membros e 35,5% são clientes casuais, algumas observações e insights podem ser extraídos:

#### Dominância de Clientes Membros:

   - A maioria dos usuários do serviço de aluguel de bicicletas são membros. Isso pode indicar uma base de clientes fiéis e recorrentes.
#### Potencial de Crescimento de Membros:

   - O fato de mais de um terço dos clientes serem casuais sugere um potencial de crescimento significativo na conversão de clientes casuais para membros.


   2. ### Análise semanal de viagens
      Na análise semanal, observamos padrões distintos no comportamento de viagem entre clientes casuais e membros.
   <br>
   
<p align="center">
      <img src="https://github.com/rafalemke/Google_Data_Analytics_Case_Study/blob/main/images/trips_week.png" alt="image" width="600" height="350">
</p>

#### Variação nos Dias da Semana:

   - Clientes casuais mostram um aumento nas viagens nos finais de semana, indicando um possível uso recreativo durante esse período.
   - Clientes membros, por outro lado, mantêm uma consistência nas viagens durante os dias da semana e reduz bastante nos finais de semana, sugerindo um uso mais regular.

Além da análise do número de registros, investigamos a duração média das viagens entre clientes membros e casuais.
<br>
<p align="center">
      <img src="https://github.com/rafalemke/Google_Data_Analytics_Case_Study/blob/main/images/media_duration_weekday.png" width="600" height="350">
</p>

### Estabilidade na Duração para Clientes Membros:
   - Clientes membros apresentam uma duração média constante ao longo da semana, indicando uma utilização regular e consistente do serviço.
### Variação Expressiva para Clientes Casuais:
   - A duração média das viagens de clientes casuais é significativamente mais alta em comparação com membros.
   - Há um aumento notável nos tempos de viagem durante sexta, sábado e domingo para clientes casuais, indicando mais uma vez um possível uso recreativo ou turístico nos fins de semana.

      

   
